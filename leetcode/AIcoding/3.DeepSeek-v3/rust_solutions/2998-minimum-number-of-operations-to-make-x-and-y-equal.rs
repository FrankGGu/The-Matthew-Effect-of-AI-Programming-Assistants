use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn minimum_operations_to_make_equal(x: i32, y: i32) -> i32 {
        if x == y {
            return 0;
        }
        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();
        queue.push_back((x, 0));
        visited.insert(x);

        while let Some((current, steps)) = queue.pop_front() {
            if current == y {
                return steps;
            }
            let next_steps = steps + 1;

            // Option 1: Increment by 1
            let next = current + 1;
            if next == y {
                return next_steps;
            }
            if !visited.contains(&next) {
                visited.insert(next);
                queue.push_back((next, next_steps));
            }

            // Option 2: Decrement by 1
            let next = current - 1;
            if next == y {
                return next_steps;
            }
            if next > 0 && !visited.contains(&next) {
                visited.insert(next);
                queue.push_back((next, next_steps));
            }

            // Option 3: Multiply by 5
            if current % 5 == 0 {
                let next = current / 5;
                if next == y {
                    return next_steps;
                }
                if !visited.contains(&next) {
                    visited.insert(next);
                    queue.push_back((next, next_steps));
                }
            }

            // Option 4: Multiply by 11
            if current % 11 == 0 {
                let next = current / 11;
                if next == y {
                    return next_steps;
                }
                if !visited.contains(&next) {
                    visited.insert(next);
                    queue.push_back((next, next_steps));
                }
            }
        }

        -1
    }
}