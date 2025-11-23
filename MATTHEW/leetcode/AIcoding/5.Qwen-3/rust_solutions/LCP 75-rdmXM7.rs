impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn find_min_moves(n: i32, k: i32) -> i32 {
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((n, 0));
        visited.insert(n);

        while let Some((current, steps)) = queue.pop_front() {
            if current == k {
                return steps;
            }

            let next1 = current + 1;
            if !visited.contains(&next1) {
                visited.insert(next1);
                queue.push_back((next1, steps + 1));
            }

            let next2 = current - 1;
            if !visited.contains(&next2) {
                visited.insert(next2);
                queue.push_back((next2, steps + 1));
            }

            let next3 = current * 2;
            if !visited.contains(&next3) {
                visited.insert(next3);
                queue.push_back((next3, steps + 1));
            }
        }

        -1
    }
}
}