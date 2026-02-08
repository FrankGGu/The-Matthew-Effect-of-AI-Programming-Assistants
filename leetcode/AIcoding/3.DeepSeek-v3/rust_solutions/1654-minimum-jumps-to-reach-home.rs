use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn minimum_jumps(forbidden: Vec<i32>, a: i32, b: i32, x: i32) -> i32 {
        let max_limit = 2000 + 2 * b.max(a);
        let forbidden_set: HashSet<i32> = forbidden.into_iter().collect();
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((0, 0, false));
        visited.insert((0, false));

        while let Some((pos, steps, is_back)) = queue.pop_front() {
            if pos == x {
                return steps;
            }

            let next_pos = pos + a;
            if next_pos <= max_limit && !forbidden_set.contains(&next_pos) && !visited.contains(&(next_pos, false)) {
                visited.insert((next_pos, false));
                queue.push_back((next_pos, steps + 1, false));
            }

            if !is_back {
                let next_pos = pos - b;
                if next_pos >= 0 && !forbidden_set.contains(&next_pos) && !visited.contains(&(next_pos, true)) {
                    visited.insert((next_pos, true));
                    queue.push_back((next_pos, steps + 1, true));
                }
            }
        }

        -1
    }
}