extends KinematicBody2D

enum {MOVING, STOP}

var speed = Vector2(150, 400)
var gravity = 1000
var velocity = Vector2()

func _physics_process(delta):
	var is_jump_interrupted = Input.is_action_just_released("game_jump") and velocity.y < 0.0
	var direction = Vector2(0,0)
	
	calculate_move_velocity(direction, is_jump_interrupted)
	velocity = move_and_slide(velocity, Vector2.UP)
	set_animation()
	set_flip()

func set_flip():
	if velocity.x == 0:
		return
	$Sprite.flip_h = true if velocity.x < 0 else false

func set_animation():
		
	var anim_name = "Idle"
	if velocity.x != 0:
		anim_name = "Run"
	if !is_on_floor():
		anim_name = "Jump"
	
	$AnimationPlayer.play(anim_name)


func calculate_move_velocity(direction, is_jump_interrupted):
	var new_velo = velocity
	new_velo.x = speed.x * direction.x
	new_velo.y += gravity * get_physics_process_delta_time()
	if direction.y == -1:
		new_velo.y = speed.y * direction.y
	if is_jump_interrupted:
		new_velo.y = 0.0
	
	velocity = new_velo



