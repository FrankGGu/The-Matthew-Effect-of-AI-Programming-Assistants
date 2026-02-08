use std::collections::VecDeque;

impl Solution {
    pub fn minimum_jumps(forbidden: Vec<i32>, a: i32, b: i32, x: i32) -> i32 {
        let forbidden_set = forbidden.iter().cloned().collect::<std::collections::HashSet<i32>>();
        let mut visited = std::collections::HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((0, false, 0)); // (position, jumped_back, steps)
        visited.insert((0, false));

        let max_reach = 2000 + a.max(b);

        while !queue.is_empty() {
            let (pos, jumped_back, steps) = queue.pop_front().unwrap();

            if pos == x {
                return steps;
            }

            // Forward jump
            let next_pos_forward = pos + a;
            if next_pos_forward <= max_reach && !forbidden_set.contains(&next_pos_forward) && !visited.contains(&(next_pos_forward, false)) {
                queue.push_back((next_pos_forward, false, steps + 1));
                visited.insert((next_pos_forward, false));
            }

            // Backward jump
            if pos - b >= 0 && !jumped_back && !forbidden_set.contains(&(pos - b)) && !visited.contains(&(pos - b, true)) {
                queue.push_back((pos - b, true, steps + 1));
                visited.insert((pos - b, true));
            }
        }

        -1
    }
}