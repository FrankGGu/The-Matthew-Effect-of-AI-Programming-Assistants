impl Solution {
    pub fn asteroid_collision(asteroids: Vec<i32>) -> Vec<i32> {
        let mut stack: Vec<i32> = Vec::new();
        for &asteroid in &asteroids {
            let mut alive = true;
            while alive && asteroid < 0 && !stack.is_empty() && stack.last().unwrap() > &0 {
                if stack.last().unwrap() < &-asteroid {
                    stack.pop();
                } else if stack.last().unwrap() == &-asteroid {
                    stack.pop();
                    alive = false;
                } else {
                    alive = false;
                }
            }
            if alive {
                stack.push(asteroid);
            }
        }
        stack
    }
}