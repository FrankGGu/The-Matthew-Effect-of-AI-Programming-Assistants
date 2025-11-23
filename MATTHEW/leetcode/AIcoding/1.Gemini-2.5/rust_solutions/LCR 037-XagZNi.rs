impl Solution {
    pub fn asteroid_collision(asteroids: Vec<i32>) -> Vec<i32> {
        let mut stack: Vec<i32> = Vec::new();

        for asteroid in asteroids {
            let mut current_asteroid = asteroid;

            // Resolve collisions with asteroids already in the stack
            // This loop continues as long as:
            // 1. The current asteroid is still alive (not exploded)
            // 2. There are asteroids in the stack
            // 3. The top asteroid in the stack is moving right (positive)
            // 4. The current asteroid is moving left (negative)
            while current_asteroid != 0
                && !stack.is_empty()
                && *stack.last().unwrap() > 0
                && current_asteroid < 0
            {
                let top_asteroid = *stack.last().unwrap();

                if top_asteroid.abs() < current_asteroid.abs() {
                    // Top asteroid explodes
                    stack.pop();
                    // current_asteroid survives and continues to collide with the next in stack
                } else if top_asteroid.abs() == current_asteroid.abs() {
                    // Both explode
                    stack.pop();
                    current_asteroid = 0; // Mark current_asteroid as destroyed
                } else {
                    // current_asteroid explodes
                    current_asteroid = 0; // Mark current_asteroid as destroyed
                }
            }

            // If current_asteroid survived all collisions (or there were no collisions of this type)
            if current_asteroid != 0 {
                stack.push(current_asteroid);
            }
        }

        stack
    }
}