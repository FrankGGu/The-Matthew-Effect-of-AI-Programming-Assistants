use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn open_lock(deadends: Vec<String>, target: String) -> i32 {
        let dead_set: HashSet<String> = deadends.into_iter().collect();
        if dead_set.contains("0000") {
            return -1;
        }

        let mut queue: VecDeque<(String, i32)> = VecDeque::new();
        queue.push_back(("0000".to_string(), 0));

        let mut visited: HashSet<String> = HashSet::new();
        visited.insert("0000".to_string());

        while let Some((curr, steps)) = queue.pop_front() {
            if curr == target {
                return steps;
            }

            for i in 0..4 {
                let mut chars: Vec<char> = curr.chars().collect();
                let digit = chars[i].to_digit(10).unwrap();

                let next_up = ((digit + 1) % 10).to_string();
                chars[i] = next_up.chars().next().unwrap();
                let up_str: String = chars.iter().collect();

                if !dead_set.contains(&up_str) && !visited.contains(&up_str) {
                    queue.push_back((up_str.clone(), steps + 1));
                    visited.insert(up_str);
                }

                let mut chars: Vec<char> = curr.chars().collect();
                let digit = chars[i].to_digit(10).unwrap();

                let next_down = ((digit + 9) % 10).to_string();
                chars[i] = next_down.chars().next().unwrap();
                let down_str: String = chars.iter().collect();

                if !dead_set.contains(&down_str) && !visited.contains(&down_str) {
                    queue.push_back((down_str.clone(), steps + 1));
                    visited.insert(down_str);
                }
            }
        }

        -1
    }
}