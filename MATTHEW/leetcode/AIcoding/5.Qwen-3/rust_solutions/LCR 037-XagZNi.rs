struct Solution;

impl Solution {
    pub fn asteroid_collision(mut asteroids: Vec<i32>) -> Vec<i32> {
        let mut stack = Vec::new();

        for asteroid in asteroids {
            let mut collide = true;
            while let Some(&last) = stack.last() {
                if last < 0 {
                    break;
                }
                if last > asteroid {
                    collide = false;
                    break;
                }
                if last == asteroid {
                    collide = false;
                    stack.pop();
                    break;
                }
                if last < asteroid {
                    stack.pop();
                }
            }
            if collide {
                stack.push(asteroid);
            }
        }

        stack
    }
}