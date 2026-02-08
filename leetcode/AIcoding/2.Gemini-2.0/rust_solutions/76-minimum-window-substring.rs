use std::collections::HashMap;

impl Solution {
    pub fn min_window(s: String, t: String) -> String {
        if s.len() < t.len() {
            return String::new();
        }

        let mut t_freq: HashMap<char, i32> = HashMap::new();
        for c in t.chars() {
            *t_freq.entry(c).or_insert(0) += 1;
        }

        let mut window_freq: HashMap<char, i32> = HashMap::new();
        let mut left = 0;
        let mut right = 0;
        let mut matched = 0;
        let mut min_len = usize::MAX;
        let mut start = 0;

        let s_chars: Vec<char> = s.chars().collect();

        while right < s_chars.len() {
            let right_char = s_chars[right];
            *window_freq.entry(right_char).or_insert(0) += 1;

            if t_freq.contains_key(&right_char) && window_freq[&right_char] <= t_freq[&right_char] {
                matched += 1;
            }

            while matched == t.len() {
                if right - left + 1 < min_len {
                    min_len = right - left + 1;
                    start = left;
                }

                let left_char = s_chars[left];
                *window_freq.entry(left_char).or_insert(0) -= 1;

                if t_freq.contains_key(&left_char) && window_freq[&left_char] < t_freq[&left_char] {
                    matched -= 1;
                }

                left += 1;
            }

            right += 1;
        }

        if min_len == usize::MAX {
            String::new()
        } else {
            s[start..start + min_len].to_string()
        }
    }
}

struct Solution;