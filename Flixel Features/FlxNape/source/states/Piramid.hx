package states;

import flixel.addons.nape.FlxNapeSprite;
import flixel.addons.nape.FlxNapeSpace;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.math.FlxRandom;
import openfl.display.FPS;

/**
 * @author TiagoLr ( ~~~ProG4mr~~~ )
 * @link https://github.com/ProG4mr
 */
class Piramid extends BaseState
{	
	private var shooter:Shooter;
	private static var levels;
	var bricks:Array<FlxNapeSprite>;
	
	override public function create():Void 
	{	
		super.create();
		FlxNapeSpace.init();
		
		add(new FlxSprite(0, 0, "assets/piramidbg.jpg"));

		if (Piramid.levels == 0)
			Piramid.levels = 10;
			
		shooter = new Shooter();
		add(shooter);	
		
		FlxNapeSpace.createWalls( -2000, -2000, 1640, 480);
		createBricks();
		
		var txt:FlxText = new FlxText(FlxG.width - 100, 30, 100, "Bricks: " + bricks.length);
		txt = new FlxText( -10, 5, 640, "      'R' - reset state, 'G' - toggle physics graphics");
		add(txt);
		txt = new FlxText( -10, 20, 640, "      'LEFT' & 'RIGHT' - switch demo");
		add(txt);
		txt = new FlxText( -10, 40, 640, "      Press 'Q' or 'W' to increase/decrease bricks");
		txt.color = 0;
		add(txt);
	}
	
	private function createBricks() 
	{
		bricks = new Array<FlxNapeSprite>();
		var brick:FlxNapeSprite;
		
		var brickHeight:Int = Std.int(8 * 40 / Piramid.levels); // magic number!
		var brickWidth:Int = brickHeight * 2;
		
		for (i in 0...levels)
		{
			for (j in 0...(Piramid.levels - i)) 
			{
				brick = new FlxNapeSprite();
				brick.makeGraphic(brickWidth, brickHeight, 0x0);
				brick.createRectangularBody();
				brick.loadGraphic("assets/brick" + Std.string(FlxG.random.int(1, 4)) + ".png");
				brick.antialiasing = true;
				brick.scale.x = brickWidth / 80;
				brick.scale.y = brickHeight / 40;
				if (FlxG.random.bool()) brick.scale.x *= -1; // add some variety
				if (FlxG.random.bool()) brick.scale.y *= -1; // add some variety.
				brick.setBodyMaterial(.5, .5, .5, 2);
				brick.body.position.y = FlxG.height - brickHeight / 2 - brickHeight * i + 2;
				brick.body.position.x = (FlxG.width / 2 - brickWidth / 2 * (Piramid.levels - i - 1)) + brickWidth * j; 
				add(brick);
				bricks.push(brick);
			}
		}
	}

	override public function update(elapsed:Float):Void 
	{	
		super.update(elapsed);
		
		if (FlxG.mouse.justPressed && FlxNapeSpace.space.gravity.y == 0)
			FlxNapeSpace.space.gravity.setxy(0, 500);
		
		if (FlxG.keys.justPressed.Q)
		{
			Piramid.levels++;
			FlxG.resetState();
		}
		if (FlxG.keys.justPressed.W)
		{
			Piramid.levels--;
			FlxG.resetState();
		}
	}
}