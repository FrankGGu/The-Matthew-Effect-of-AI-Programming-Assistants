impl Solution {
    pub fn asteroid_collision(asteroids: Vec<i32>) -> Vec<i32> {
        let mut stack = Vec::new();
        for &asteroid in asteroids.iter() {
            let mut exploded = false;
            while let Some(&top) = stack.last() {
                if top > 0 && asteroid < 0 {
                    if top.abs() > asteroid.abs() {
                        exploded = true;
                        break;
                    } else if top.abs() == asteroid.abs() {
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