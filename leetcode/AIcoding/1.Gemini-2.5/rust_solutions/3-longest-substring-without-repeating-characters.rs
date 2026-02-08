use std::collections::HashMap;

impl Solution {
    pub fn length_of_longest_substring(s: String) -> i32 {
        let mut char_map: HashMap<char, usize> = HashMap::new();
        let mut max_len = 0;
        let mut left = 0;

        for (right, c) in s.chars().enumerate() {
            if let Some(&prev_index) = char_map.get(&c) {
                left = left.max(prev_index + 1);
            }
            char_map.insert(c, right);
            max_len = max_len.max(right - left + 1);
        }

        max_len as i32
    }
}