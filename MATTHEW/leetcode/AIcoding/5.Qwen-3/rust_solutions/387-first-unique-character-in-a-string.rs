impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn first_unique_char(s: String) -> i32 {
        let mut char_count = HashMap::new();

        for c in s.chars() {
            *char_count.entry(c).or_insert(0) += 1;
        }

        for (i, c) in s.chars().enumerate() {
            if char_count.get(&c) == Some(&1) {
                return i as i32;
            }
        }

        -1
    }
}
}