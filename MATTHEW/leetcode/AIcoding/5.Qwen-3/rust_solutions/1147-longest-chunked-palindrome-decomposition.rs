impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn longest_decomposition(s: String) -> i32 {
        let mut result = 0;
        let mut left = 0;
        let mut right = s.len() - 1;
        let mut left_map = HashMap::new();
        let mut right_map = HashMap::new();
        let s_bytes = s.as_bytes();

        while left <= right {
            let left_char = s_bytes[left];
            let right_char = s_bytes[right];

            if left_char == right_char {
                let key = (left_char, left, right);
                *left_map.entry(key).or_insert(0) += 1;
                *right_map.entry(key).or_insert(0) += 1;

                if left_map[&key] == right_map[&key] {
                    result += 1;
                    left_map.clear();
                    right_map.clear();
                    left += 1;
                    right -= 1;
                } else {
                    left += 1;
                    right -= 1;
                }
            } else {
                left += 1;
                right -= 1;
            }
        }

        result
    }
}
}