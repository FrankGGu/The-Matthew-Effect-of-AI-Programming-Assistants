impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn max_power(s: String) -> i32 {
        if s.is_empty() {
            return 0;
        }

        let mut max_len = 1;
        let mut current_len = 1;

        let chars: Vec<char> = s.chars().collect();

        for i in 1..chars.len() {
            if chars[i] == chars[i - 1] {
                current_len += 1;
                if current_len > max_len {
                    max_len = current_len;
                }
            } else {
                current_len = 1;
            }
        }

        max_len
    }
}
}