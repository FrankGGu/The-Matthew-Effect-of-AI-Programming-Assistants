use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn open_lock(deadends: Vec<String>, target: String) -> i32 {
        let deadends_set: HashSet<String> = deadends.into_iter().collect();

        if deadends_set.contains("0000") {
            return -1;
        }

        let mut queue: VecDeque<(String, i32)> = VecDeque::new();
        let mut visited: HashSet<String> = HashSet::new();

        queue.push_back(("0000".to_string(), 0));
        visited.insert("0000".to_string());

        while let Some((current_lock, turns)) = queue.pop_front() {
            if current_lock == target {
                return turns;
            }

            for i in 0..4 {
                let mut chars: Vec<char> = current_lock.chars().collect();
                let digit = chars[i].to_digit(10).unwrap();

                // Rotate up
                chars[i] = ((digit + 1) % 10).to_string().chars().next().unwrap();
                let next_lock_up: String = chars.iter().collect();
                if !visited.contains(&next_lock_up) && !deadends_set.contains(&next_lock_up) {
                    visited.insert(next_lock_up.clone());
                    queue.push_back((next_lock_up, turns + 1));
                }

                // Reset char at index i to current_lock's digit for the down rotation
                chars[i] = current_lock.chars().nth(i).unwrap();

                // Rotate down
                chars[i] = ((digit + 9) % 10).to_string().chars().next().unwrap(); // (digit - 1 + 10) % 10
                let next_lock_down: String = chars.iter().collect();
                if !visited.contains(&next_lock_down) && !deadends_set.contains(&next_lock_down) {
                    visited.insert(next_lock_down.clone());
                    queue.push_back((next_lock_down, turns + 1));
                }
            }
        }

        -1
    }
}