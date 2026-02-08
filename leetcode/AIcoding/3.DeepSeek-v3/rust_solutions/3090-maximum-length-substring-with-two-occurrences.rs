use std::collections::HashMap;

impl Solution {
    pub fn maximum_length_substring(s: String) -> i32 {
        let mut max_len = 0;
        let mut char_count = HashMap::new();
        let s_chars: Vec<char> = s.chars().collect();
        let mut left = 0;

        for right in 0..s_chars.len() {
            *char_count.entry(s_chars[right]).or_insert(0) += 1;

            while *char_count.get(&s_chars[right]).unwrap() > 2 {
                *char_count.get_mut(&s_chars[left]).unwrap() -= 1;
                if *char_count.get(&s_chars[left]).unwrap() == 0 {
                    char_count.remove(&s_chars[left]);
                }
                left += 1;
            }

            max_len = max_len.max((right - left + 1) as i32);
        }

        max_len
    }
}