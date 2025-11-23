impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn open_lock(mut deadends: Vec<String>, target: String) -> i32 {
        let dead_set: HashSet<String> = deadends.drain().collect();
        let start = "0000".to_string();

        if dead_set.contains(&start) || dead_set.contains(&target) {
            return -1;
        }

        let mut queue = VecDeque::new();
        queue.push_back((start, 0));
        let mut visited = HashSet::new();
        visited.insert(start);

        while let Some((current, steps)) = queue.pop_front() {
            if current == target {
                return steps;
            }

            for next in get_next_states(&current) {
                if !visited.contains(&next) && !dead_set.contains(&next) {
                    visited.insert(next.clone());
                    queue.push_back((next, steps + 1));
                }
            }
        }

        -1
    }
}

fn get_next_states(current: &str) -> Vec<String> {
    let mut result = Vec::new();
    let chars: Vec<char> = current.chars().collect();

    for i in 0..4 {
        let digit = chars[i] as u8 - b'0';

        // Turn clockwise
        let next_digit = (digit + 1) % 10;
        let mut next_state = chars.clone();
        next_state[i] = (b'0' + next_digit) as char;
        result.push(next_state.iter().collect::<String>());

        // Turn counter-clockwise
        let next_digit = (digit + 9) % 10;
        let mut next_state = chars.clone();
        next_state[i] = (b'0' + next_digit) as char;
        result.push(next_state.iter().collect::<String>());
    }

    result
}
}