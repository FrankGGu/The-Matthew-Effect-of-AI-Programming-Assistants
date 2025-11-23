impl Solution {
    pub fn asteroid_collision(asteroids: Vec<i32>) -> Vec<i32> {
        let mut stack: Vec<i32> = Vec::new();
        for asteroid in asteroids {
            let mut alive = true;
            while alive && asteroid < 0 && !stack.is_empty() && stack.last().unwrap() > &0 {
                let top = *stack.last().unwrap();
                if top < -asteroid {
                    stack.pop();
                } else if top == -asteroid {
                    stack.pop();
                    alive = false;
                } else {
                    alive = false;
                }
            }
            if alive {
                if asteroid > 0 || stack.is_empty() || stack.last().unwrap() < &0 {
                    stack.push(asteroid);
                }
            }
        }
        stack
    }
}