use std::collections::HashMap;

impl Solution {
    pub fn min_window(s: String, t: String) -> String {
        if t.is_empty() {
            return String::new();
        }

        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();

        let mut t_freq: HashMap<u8, i32> = HashMap::new();
        for &c in t_bytes {
            *t_freq.entry(c).or_insert(0) += 1;
        }

        let mut window_freq: HashMap<u8, i32> = HashMap::new();
        let mut left = 0;
        let mut right = 0;
        let mut matched = 0;
        let mut min_len = i32::MAX;
        let mut start = 0;

        while right < s_bytes.len() {
            let c = s_bytes[right];
            if t_freq.contains_key(&c) {
                *window_freq.entry(c).or_insert(0) += 1;
                if window_freq[&c] == t_freq[&c] {
                    matched += 1;
                }
            }

            while matched == t_freq.len() {
                if (right - left + 1) as i32 < min_len {
                    min_len = (right - left + 1) as i32;
                    start = left;
                }

                let left_c = s_bytes[left];
                if t_freq.contains_key(&left_c) {
                    *window_freq.entry(left_c).or_insert(0) -= 1;
                    if window_freq[&left_c] < t_freq[&left_c] {
                        matched -= 1;
                    }
                }
                left += 1;
            }

            right += 1;
        }

        if min_len == i32::MAX {
            return String::new();
        }

        String::from_utf8(s_bytes[start..start + min_len as usize].to_vec()).unwrap()
    }
}