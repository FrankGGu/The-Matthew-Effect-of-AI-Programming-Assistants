use std::collections::HashMap;

impl Solution {
    pub fn min_window(s: String, t: String) -> String {
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();
        let mut need = HashMap::new();
        let mut window = HashMap::new();

        for &c in &t_chars {
            *need.entry(c).or_insert(0) += 1;
        }

        let (mut left, mut right) = (0, 0);
        let mut valid = 0;
        let mut start = 0;
        let mut len = usize::MAX;

        while right < s_chars.len() {
            let c = s_chars[right];
            right += 1;

            if need.contains_key(&c) {
                *window.entry(c).or_insert(0) += 1;
                if window[&c] == need[&c] {
                    valid += 1;
                }
            }

            while valid == need.len() {
                if right - left < len {
                    start = left;
                    len = right - left;
                }

                let d = s_chars[left];
                left += 1;

                if need.contains_key(&d) {
                    if window[&d] == need[&d] {
                        valid -= 1;
                    }
                    *window.entry(d).or_insert(0) -= 1;
                }
            }
        }

        if len == usize::MAX {
            "".to_string()
        } else {
            s_chars[start..start + len].iter().collect()
        }
    }
}