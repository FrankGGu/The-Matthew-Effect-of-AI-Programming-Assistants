use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn open_lock(deadends: Vec<String>, target: String) -> i32 {
        let mut visited = HashSet::new();
        for deadend in deadends {
            visited.insert(deadend);
        }
        if visited.contains("0000") {
            return -1;
        }
        let mut queue = VecDeque::new();
        queue.push_back(("0000".to_string(), 0));
        visited.insert("0000".to_string());

        while let Some((current, steps)) = queue.pop_front() {
            if current == target {
                return steps;
            }
            for i in 0..4 {
                let mut chars: Vec<char> = current.chars().collect();
                let original = chars[i];

                // Turn forward
                chars[i] = if original == '9' { '0' } else { (original as u8 + 1) as char };
                let next_forward = chars.iter().collect::<String>();
                if !visited.contains(&next_forward) {
                    visited.insert(next_forward.clone());
                    queue.push_back((next_forward, steps + 1));
                }

                // Turn backward
                chars[i] = if original == '0' { '9' } else { (original as u8 - 1) as char };
                let next_backward = chars.iter().collect::<String>();
                if !visited.contains(&next_backward) {
                    visited.insert(next_backward.clone());
                    queue.push_back((next_backward, steps + 1));
                }
            }
        }
        -1
    }
}