impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_operations(mut n: i32) -> i32 {
        let mut queue = VecDeque::new();
        let mut visited = std::collections::HashSet::new();
        queue.push_back(n);
        visited.insert(n);
        let mut steps = 0;

        while !queue.is_empty() {
            let level_size = queue.len();
            for _ in 0..level_size {
                if let Some(current) = queue.pop_front() {
                    if current == 0 {
                        return steps;
                    }
                    if current % 2 == 0 {
                        let next = current / 2;
                        if !visited.contains(&next) {
                            visited.insert(next);
                            queue.push_back(next);
                        }
                    } else {
                        let next1 = current + 1;
                        let next2 = current - 1;
                        if !visited.contains(&next1) {
                            visited.insert(next1);
                            queue.push_back(next1);
                        }
                        if !visited.contains(&next2) {
                            visited.insert(next2);
                            queue.push_back(next2);
                        }
                    }
                }
            }
            steps += 1;
        }
        -1
    }
}
}