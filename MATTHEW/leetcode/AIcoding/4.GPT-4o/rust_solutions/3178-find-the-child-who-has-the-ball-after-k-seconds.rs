pub fn find_child_with_ball(balls: Vec<i32>, k: i32) -> i32 {
    let n = balls.len() as i32;
    let mut position = 0;

    for _ in 0..k {
        position = (position + balls[position as usize]) % n;
    }

    position
}