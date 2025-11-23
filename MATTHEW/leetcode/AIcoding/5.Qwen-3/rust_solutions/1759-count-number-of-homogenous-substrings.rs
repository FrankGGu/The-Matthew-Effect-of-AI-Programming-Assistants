impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_homogenous_substrings(s: String) -> i32 {
        let mut count = 0;
        let mut prev_char = '\0';
        let mut current_length = 0;

        for c in s.chars() {
            if c == prev_char {
                current_length += 1;
            } else {
                prev_char = c;
                current_length = 1;
            }
            count += current_length;
        }

        count
    }
}
}