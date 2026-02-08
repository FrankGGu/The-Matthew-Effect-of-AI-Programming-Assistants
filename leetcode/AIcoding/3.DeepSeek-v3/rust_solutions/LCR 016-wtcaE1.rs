use std::collections::HashMap;

impl Solution {
    pub fn length_of_longest_substring(s: String) -> i32 {
        let mut map = HashMap::new();
        let mut max_len = 0;
        let mut start = 0;
        let s_chars: Vec<char> = s.chars().collect();

        for end in 0..s_chars.len() {
            let c = s_chars[end];
            if let Some(&prev_pos) = map.get(&c) {
                start = start.max(prev_pos + 1);
            }
            map.insert(c, end);
            max_len = max_len.max(end - start + 1);
        }

        max_len as i32
    }
}