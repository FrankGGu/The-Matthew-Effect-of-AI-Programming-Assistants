impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn min_time_to_cook(target_time: i32) -> i32 {
        let mut seen = HashSet::new();
        let mut queue = std::collections::VecDeque::new();
        queue.push_back(0);
        seen.insert(0);

        let mut time = 0;

        while let Some(current) = queue.pop_front() {
            if current == target_time {
                return time;
            }

            let next = current * 2;
            if !seen.contains(&next) {
                seen.insert(next);
                queue.push_back(next);
            }

            let next = current + 1;
            if !seen.contains(&next) {
                seen.insert(next);
                queue.push_back(next);
            }

            time += 1;
        }

        -1
    }
}
}