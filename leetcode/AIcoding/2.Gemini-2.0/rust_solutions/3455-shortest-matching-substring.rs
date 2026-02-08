use std::collections::HashMap;

impl Solution {
    pub fn min_window(s: String, t: String) -> String {
        if t.is_empty() {
            return "".to_string();
        }

        let mut need: HashMap<char, i32> = HashMap::new();
        let mut window: HashMap<char, i32> = HashMap::new();

        for c in t.chars() {
            *need.entry(c).or_insert(0) += 1;
        }

        let mut left = 0;
        let mut right = 0;
        let mut valid = 0;
        let mut start = 0;
        let mut len = i32::MAX;

        let s_chars: Vec<char> = s.chars().collect();

        while right < s_chars.len() {
            let c = s_chars[right];
            right += 1;

            if need.contains_key(&c) {
                *window.entry(c).or_insert(0) += 1;
                if window.get(&c) == need.get(&c) {
                    valid += 1;
                }
            }

            while valid == need.len() {
                if right as i32 - left as i32 < len {
                    start = left;
                    len = right as i32 - left as i32;
                }

                let d = s_chars[left];
                left += 1;

                if need.contains_key(&d) {
                    if window.get(&d) == need.get(&d) {
                        valid -= 1;
                    }
                    *window.entry(d).or_insert(0) -= 1;
                }
            }
        }

        if len == i32::MAX {
            return "".to_string();
        } else {
            return s[start..start + len as usize].to_string();
        }
    }
}