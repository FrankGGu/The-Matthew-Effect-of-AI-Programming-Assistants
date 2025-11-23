use std::collections::HashSet;
use std::collections::VecDeque;

impl Solution {
    pub fn can_measure_water(jug1_capacity: i32, jug2_capacity: i32, target_capacity: i32) -> bool {
        if jug1_capacity + jug2_capacity < target_capacity {
            return false;
        }
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((0, 0));
        visited.insert((0, 0));

        while let Some((a, b)) = queue.pop_front() {
            if a == target_capacity || b == target_capacity || a + b == target_capacity {
                return true;
            }
            let next_states = vec![
                (jug1_capacity, b),
                (a, jug2_capacity),
                (0, b),
                (a, 0),
                (a - a.min(jug2_capacity - b), b + a.min(jug2_capacity - b)),
                (a + b.min(jug1_capacity - a), b - b.min(jug1_capacity - a)),
            ];

            for state in next_states {
                if !visited.contains(&state) {
                    visited.insert(state);
                    queue.push_back(state);
                }
            }
        }
        false
    }
}