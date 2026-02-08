use std::collections::HashMap;

impl Solution {
    pub fn min_window(s: String, t: String) -> String {
        if s.is_empty() || t.is_empty() {
            return String::new();
        }

        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();

        let mut target_counts = HashMap::new();
        for &c in &t_chars {
            *target_counts.entry(c).or_insert(0) += 1;
        }

        let required = target_counts.len();
        let mut formed = 0;
        let mut window_counts = HashMap::new();

        let mut left = 0;
        let mut right = 0;

        let mut ans = (usize::MAX, 0, 0);

        while right < s_chars.len() {
            let c = s_chars[right];
            *window_counts.entry(c).or_insert(0) += 1;

            if target_counts.contains_key(&c) && window_counts[&c] == target_counts[&c] {
                formed += 1;
            }

            while left <= right && formed == required {
                let current_len = right - left + 1;
                if current_len < ans.0 {
                    ans = (current_len, left, right);
                }

                let left_char = s_chars[left];
                *window_counts.entry(left_char).or_insert(0) -= 1;

                if target_counts.contains_key(&left_char) && window_counts[&left_char] < target_counts[&left_char] {
                    formed -= 1;
                }

                left += 1;
            }

            right += 1;
        }

        if ans.0 == usize::MAX {
            String::new()
        } else {
            s_chars[ans.1..=ans.2].iter().collect()
        }
    }
}