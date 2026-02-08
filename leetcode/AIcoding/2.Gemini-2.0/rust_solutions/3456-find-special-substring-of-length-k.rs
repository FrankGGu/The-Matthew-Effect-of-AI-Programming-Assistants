use std::collections::HashMap;

impl Solution {
    pub fn find_special_substring(s: String, k: i32, char1: char, char2: char) -> i32 {
        let s_bytes = s.as_bytes();
        let n = s_bytes.len();
        let k = k as usize;
        let mut max_len = 0;
        let mut left = 0;
        let mut char1_count = 0;
        let mut char2_count = 0;
        let mut other_count = 0;

        for right in 0..n {
            if s_bytes[right] as char == char1 {
                char1_count += 1;
            } else if s_bytes[right] as char == char2 {
                char2_count += 1;
            } else {
                other_count += 1;
            }

            while char1_count > k || char2_count > k || other_count > 0 {
                if s_bytes[left] as char == char1 {
                    char1_count -= 1;
                } else if s_bytes[left] as char == char2 {
                    char2_count -= 1;
                } else {
                    other_count -= 1;
                }
                left += 1;
            }

            if right - left + 1 >= k {
                max_len = max_len.max((right - left + 1) as i32);
            }
        }

        max_len
    }
}