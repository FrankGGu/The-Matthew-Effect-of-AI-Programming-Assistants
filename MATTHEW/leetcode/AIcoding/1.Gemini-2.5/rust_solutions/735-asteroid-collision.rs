impl Solution {
    pub fn asteroid_collision(asteroids: Vec<i32>) -> Vec<i32> {
        let mut stack: Vec<i32> = Vec::new();

        for &asteroid in asteroids.iter() {
            let mut current_asteroid = asteroid;
            let mut exploded = false;

            while let Some(&top_asteroid) = stack.last() {
                if current_asteroid > 0 || top_asteroid < 0 {
                    // No collision:
                    // - Current asteroid is positive (moving right)
                    // - Top of stack is negative (moving left)
                    // They are moving in the same direction or away from each other
                    break;
                } else {
                    // Collision scenario: current_asteroid < 0 and top_asteroid > 0
                    if top_asteroid.abs() < current_asteroid.abs() {
                        // Top asteroid is smaller, it explodes
                        stack.pop();
                        // Current asteroid continues its journey, might collide with next
                    } else if top_asteroid.abs() == current_asteroid.abs() {
                        // Both asteroids are of the same size, both explode
                        stack.pop();
                        exploded = true; // Current asteroid also exploded
                        break; // Stop processing this current_asteroid
                    } else {
                        // Current asteroid is smaller, it explodes
                        exploded = true; // Current asteroid exploded
                        break; // Stop processing this current_asteroid
                    }
                }
            }

            if !exploded {
                stack.push(current_asteroid);
            }
        }

        stack
    }
}