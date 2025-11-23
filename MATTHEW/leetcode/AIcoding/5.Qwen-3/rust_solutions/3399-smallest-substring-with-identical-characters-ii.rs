impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn smallest_substring(s: String) -> String {
        let mut char_count = HashMap::new();
        let mut left = 0;
        let mut min_length = usize::MAX;
        let mut result = String::new();
        let chars: Vec<char> = s.chars().collect();

        for (right, &c) in chars.iter().enumerate() {
            *char_count.entry(c).or_insert(0) += 1;

            while char_count.values().all(|&count| count >= 2) {
                let current_length = right - left + 1;
                if current_length < min_length {
                    min_length = current_length;
                    result = s[left..=right].to_string();
                }

                let left_char = chars[left];
                *char_count.get_mut(&left_char).unwrap() -= 1;
                if *char_count.get_mut(&left_char).unwrap() == 0 {
                    char_count.remove(&left_char);
                }
                left += 1;
            }
        }

        result
    }
}
}