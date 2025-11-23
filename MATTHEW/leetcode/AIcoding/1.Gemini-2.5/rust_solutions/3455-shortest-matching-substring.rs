use std::collections::HashMap;

impl Solution {
    pub fn min_window(s: String, t: String) -> String {
        if t.is_empty() {
            return String::new();
        }

        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();

        let mut target_counts: HashMap<char, i32> = HashMap::new();
        for &c in t_chars.iter() {
            *target_counts.entry(c).or_insert(0) += 1;
        }

        let required_match_count = t_chars.len() as i32;

        let mut window_counts: HashMap<char, i32> = HashMap::new();
        let mut current_match_count = 0;

        let mut min_len = usize::MAX;
        let mut min_start = 0;
        let mut min_end = 0;

        let mut left = 0;
        for right in 0..s_chars.len() {
            let r_char = s_chars[right];
            *window_counts.entry(r_char).or_insert(0) += 1;

            if let Some(&required_count) = target_counts.get(&r_char) {
                if window_counts[&r_char] <= required_count {
                    current_match_count += 1;
                }
            }

            while current_match_count == required_match_count {
                let current_len = right - left + 1;
                if current_len < min_len {
                    min_len = current_len;
                    min_start = left;
                    min_end = right;
                }

                let l_char = s_chars[left];
                *window_counts.entry(l_char).or_insert(0) -= 1;

                if let Some(&required_count) = target_counts.get(&l_char) {
                    if window_counts[&l_char] < required_count {
                        current_match_count -= 1;
                    }
                }
                left += 1;
            }
        }

        if min_len == usize::MAX {
            String::new()
        } else {
            s_chars[min_start..=min_end].iter().collect()
        }
    }
}