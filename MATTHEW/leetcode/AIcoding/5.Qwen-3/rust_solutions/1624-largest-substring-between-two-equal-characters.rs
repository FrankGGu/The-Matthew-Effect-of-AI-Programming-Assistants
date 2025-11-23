impl Solution {

use std::cmp;

impl Solution {
    pub fn largest_substring(s: String) -> i32 {
        let mut max_len = -1;
        let mut first_occurrence = std::collections::HashMap::new();

        for (i, c) in s.chars().enumerate() {
            if let Some(&start) = first_occurrence.get(&c) {
                let len = i as i32 - start as i32 - 1;
                if len > max_len {
                    max_len = len;
                }
            } else {
                first_occurrence.insert(c, i);
            }
        }

        max_len
    }
}
}