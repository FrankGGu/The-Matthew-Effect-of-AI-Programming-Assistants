use std::collections::HashSet;

impl Solution {
    pub fn can_measure_water(jug1_capacity: i32, jug2_capacity: i32, target_capacity: i32) -> bool {
        if target_capacity > jug1_capacity + jug2_capacity {
            return false;
        }

        let mut queue = std::collections::VecDeque::new();
        queue.push_back(0);

        let mut visited = HashSet::new();
        visited.insert(0);

        while let Some(state) = queue.pop_front() {
            if state == target_capacity {
                return true;
            }

            let states = vec![
                state + jug1_capacity,
                state - jug1_capacity,
                state + jug2_capacity,
                state - jug2_capacity,
            ];

            for next_state in states {
                if next_state >= 0 && next_state <= jug1_capacity + jug2_capacity && !visited.contains(&next_state) {
                    queue.push_back(next_state);
                    visited.insert(next_state);
                }
            }
        }

        false
    }
}