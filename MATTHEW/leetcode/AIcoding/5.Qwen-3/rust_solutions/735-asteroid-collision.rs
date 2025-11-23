struct Solution;

impl Solution {
    pub fn asteroid_collision(mut asteroids: Vec<i32>) -> Vec<i32> {
        let mut stack = Vec::new();

        for asteroid in asteroids {
            let mut collide = false;
            while let Some(&top) = stack.last() {
                if top < 0 {
                    break;
                }
                if top > asteroid {
                    break;
                }
                if top == asteroid {
                    stack.pop();
                    collide = true;
                    break;
                }
                if top < asteroid {
                    stack.pop();
                    collide = true;
                }
            }
            if !collide {
                stack.push(asteroid);
            }
        }

        stack
    }
}