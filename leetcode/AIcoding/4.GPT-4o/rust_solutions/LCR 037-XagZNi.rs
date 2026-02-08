pub fn asteroid_collision(asteroids: Vec<i32>) -> Vec<i32> {
    let mut stack = Vec::new();
    for &asteroid in asteroids.iter() {
        let mut alive = true;
        while alive && asteroid < 0 && !stack.is_empty() && *stack.last().unwrap() > 0 {
            let top = stack.pop().unwrap();
            if top == -asteroid {
                alive = false;
            } else if top > -asteroid {
                stack.push(top);
                alive = false;
            } else {
                continue;
            }
        }
        if alive {
            stack.push(asteroid);
        }
    }
    stack
}