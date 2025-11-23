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

        while !queue.is_empty() {
            let (current, steps) = queue.pop_front().unwrap();

            if current == target {
                return steps;
            }

            for i in 0..4 {
                let mut chars = current.chars().collect::<Vec<_>>();
                let original_digit = chars[i].to_digit(10).unwrap();

                let next_digit = (original_digit + 1) % 10;
                chars[i] = std::char::from_digit(next_digit, 10).unwrap();
                let next_combination = chars.iter().collect::<String>();

                if !dead_set.contains(&next_combination) && !visited.contains(&next_combination) {
                    queue.push_back((next_combination.clone(), steps + 1));
                    visited.insert(next_combination);
                }

                let prev_digit = (original_digit + 9) % 10;
                chars[i] = std::char::from_digit(prev_digit, 10).unwrap();
                let prev_combination = chars.iter().collect::<String>();

                if !dead_set.contains(&prev_combination) && !visited.contains(&prev_combination) {
                    queue.push_back((prev_combination.clone(), steps + 1));
                    visited.insert(prev_combination);
                }
            }
        }

        -1
    }
}