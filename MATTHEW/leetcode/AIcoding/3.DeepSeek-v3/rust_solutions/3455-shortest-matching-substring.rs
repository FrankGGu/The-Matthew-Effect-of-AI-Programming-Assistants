use std::collections::HashMap;

impl Solution {
    pub fn min_window(s: String, t: String) -> String {
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();
        let mut target = HashMap::new();
        for &c in t_bytes {
            *target.entry(c).or_insert(0) += 1;
        }
        let required = target.len();
        let mut formed = 0;
        let mut window_counts = HashMap::new();
        let mut left = 0;
        let mut result = (0, s.len() + 1);
        for right in 0..s_bytes.len() {
            let c = s_bytes[right];
            if target.contains_key(&c) {
                *window_counts.entry(c).or_insert(0) += 1;
                if window_counts[&c] == target[&c] {
                    formed += 1;
                }
            }
            while left <= right && formed == required {
                if right - left < result.1 - result.0 {
                    result = (left, right);
                }
                let c_left = s_bytes[left];
                if target.contains_key(&c_left) {
                    *window_counts.get_mut(&c_left).unwrap() -= 1;
                    if window_counts[&c_left] < target[&c_left] {
                        formed -= 1;
                    }
                }
                left += 1;
            }
        }
        if result.1 > s.len() {
            "".to_string()
        } else {
            s[result.0..=result.1].to_string()
        }
    }
}