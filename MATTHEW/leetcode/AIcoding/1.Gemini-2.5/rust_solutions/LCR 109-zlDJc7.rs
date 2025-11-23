use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn open_lock(deadends: Vec<String>, target: String) -> i32 {
        let mut deadends_set: HashSet<String> = deadends.into_iter().collect();

        if deadends_set.contains("0000") {
            return -1;
        }
        if target == "0000" {
            return 0;
        }

        let mut queue: VecDeque<(String, i32)> = VecDeque::new();
        queue.push_back(("0000".to_string(), 0));

        let mut visited: HashSet<String> = HashSet::new();
        visited.insert("0000".to_string());

        while let Some((current_lock, steps)) = queue.pop_front() {
            for i in 0..4 {
                let mut chars: Vec<char> = current_lock.chars().collect();
                let digit = chars[i].to_digit(10).unwrap() as i32;

                // Increment digit
                let next_digit_inc = ((digit + 1) % 10).to_string().chars().next().unwrap();
                let mut next_chars_inc = chars.clone();
                next_chars_inc[i] = next_digit_inc;
                let next_lock_inc: String = next_chars_inc.into_iter().collect();

                if !visited.contains(&next_lock_inc) && !deadends_set.contains(&next_lock_inc) {
                    if next_lock_inc == target {
                        return steps + 1;
                    }
                    visited.insert(next_lock_inc.clone());
                    queue.push_back((next_lock_inc, steps + 1));
                }

                // Decrement digit
                let next_digit_dec = ((digit - 1 + 10) % 10).to_string().chars().next().unwrap();
                let mut next_chars_dec = chars; // Use the original chars again
                next_chars_dec[i] = next_digit_dec;
                let next_lock_dec: String = next_chars_dec.into_iter().collect();

                if !visited.contains(&next_lock_dec) && !deadends_set.contains(&next_lock_dec) {
                    if next_lock_dec == target {
                        return steps + 1;
                    }
                    visited.insert(next_lock_dec.clone());
                    queue.push_back((next_lock_dec, steps + 1));
                }
            }
        }

        -1
    }
}