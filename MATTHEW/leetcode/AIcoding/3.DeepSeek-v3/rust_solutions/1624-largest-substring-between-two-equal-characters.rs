use std::collections::HashMap;

impl Solution {
    pub fn max_length_between_equal_characters(s: String) -> i32 {
        let mut first_occurrence = HashMap::new();
        let mut max_len = -1;

        for (i, c) in s.chars().enumerate() {
            if let Some(&first_pos) = first_occurrence.get(&c) {
                max_len = max_len.max((i - first_pos - 1) as i32);
            } else {
                first_occurrence.insert(c, i);
            }
        }

        max_len
    }
}