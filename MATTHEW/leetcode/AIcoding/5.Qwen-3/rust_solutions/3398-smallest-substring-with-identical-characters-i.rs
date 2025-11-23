impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn minimum_window(s: String, t: String) -> String {
        if s.is_empty() || t.is_empty() {
            return String::new();
        }

        let mut char_count = HashMap::new();
        for c in t.chars() {
            *char_count.entry(c).or_insert(0) += 1;
        }

        let mut required = char_count.len();
        let mut formed = 0;
        let mut left = 0;
        let mut min_length = usize::MAX;
        let mut result = (0, 0);

        let s_chars: Vec<char> = s.chars().collect();

        for right in 0..s_chars.len() {
            let c = s_chars[right];
            *char_count.entry(c).or_insert(0) -= 1;
            if char_count[&c] == 0 {
                formed += 1;
            }

            while formed == required {
                if right - left + 1 < min_length {
                    min_length = right - left + 1;
                    result = (left, right);
                }

                let left_char = s_chars[left];
                *char_count.entry(left_char).or_insert(0) += 1;
                if char_count[&left_char] > 0 {
                    formed -= 1;
                }
                left += 1;
            }
        }

        if min_length == usize::MAX {
            String::new()
        } else {
            s_chars[result.0..=result.1].iter().collect()
        }
    }
}
}