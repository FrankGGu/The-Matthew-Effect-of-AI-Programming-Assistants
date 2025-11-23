impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn min_operations(mut x: i32, y: i32) -> i32 {
        if x == y {
            return 0;
        }

        let mut visited = HashSet::new();
        let mut queue = std::collections::VecDeque::new();
        queue.push_back((x, 0));
        visited.insert(x);

        while let Some((current, ops)) = queue.pop_front() {
            let next_values = vec![
                current + 1,
                current - 1,
                current * 2,
                current / 2,
            ];

            for next in next_values {
                if next == y {
                    return ops + 1;
                }

                if next > 0 && !visited.contains(&next) {
                    visited.insert(next);
                    queue.push_back((next, ops + 1));
                }
            }
        }

        -1
    }
}
}