impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn is_subsequence(s: &str, t: &str) -> bool {
        let mut count = HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }
        for c in t.chars() {
            if let Some(e) = count.get_mut(&c) {
                *e -= 1;
                if *e == 0 {
                    count.remove(&c);
                }
            }
        }
        count.is_empty()
    }

    pub fn is_substring(s: &str, t: &str) -> bool {
        let s_len = s.len();
        let t_len = t.len();
        if s_len > t_len {
            return false;
        }
        for i in 0..=t_len - s_len {
            let substring = &t[i..i + s_len];
            if Self::is_subsequence(s, substring) {
                return true;
            }
        }
        false
    }

    pub fn substr_count(s: &str, t: &str) -> i32 {
        let t_len = t.len();
        let mut count = 0;
        for i in 0..t_len {
            for j in i + 1..=t_len {
                let substring = &t[i..j];
                if Self::is_substring(s, substring) {
                    count += 1;
                }
            }
        }
        count
    }
}
}