use std::collections::HashMap;

impl Solution {
    pub fn min_window(s: String, t: String) -> String {
        let mut t_count = HashMap::new();
        for c in t.chars() {
            *t_count.entry(c).or_insert(0) += 1;
        }

        let mut start = 0;
        let mut end = 0;
        let mut min_len = usize::MAX;
        let mut min_start = 0;
        let mut count = 0;
        let mut s_count = HashMap::new();

        while end < s.len() {
            let right_char = s.chars().nth(end).unwrap();
            if let Some(&t_char_count) = t_count.get(&right_char) {
                let entry = s_count.entry(right_char).or_insert(0);
                *entry += 1;
                if *entry == t_char_count {
                    count += 1;
                }
            }
            end += 1;

            while count == t_count.len() {
                if end - start < min_len {
                    min_len = end - start;
                    min_start = start;
                }
                let left_char = s.chars().nth(start).unwrap();
                if let Some(&t_char_count) = t_count.get(&left_char) {
                    let entry = s_count.get_mut(&left_char).unwrap();
                    *entry -= 1;
                    if *entry < t_char_count {
                        count -= 1;
                    }
                }
                start += 1;
            }
        }

        if min_len == usize::MAX {
            return String::new();
        }
        s[min_start..min_start + min_len].to_string()
    }
}