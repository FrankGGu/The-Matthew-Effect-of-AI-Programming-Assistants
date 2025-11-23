impl Solution {
    pub fn asteroid_collision(asteroids: Vec<i32>) -> Vec<i32> {
        let mut stack: Vec<i32> = Vec::new();

        for &asteroid in asteroids.iter() {
            let mut exploded = false;

            while let Some(&last) = stack.last() {
                if last > 0 && asteroid < 0 {
                    if last.abs() > asteroid.abs() {
                        exploded = true;
                        break;
                    } else if last.abs() == asteroid.abs() {
                        stack.pop();
                        exploded = true;
                        break;
                    } else {
                        stack.pop();
                    }
                } else {
                    break;
                }
            }

            if !exploded {
                stack.push(asteroid);
            }
        }

        stack
    }
}