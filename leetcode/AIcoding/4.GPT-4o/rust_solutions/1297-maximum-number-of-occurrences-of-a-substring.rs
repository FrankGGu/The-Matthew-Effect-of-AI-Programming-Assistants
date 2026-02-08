use std::collections::HashMap;

impl Solution {
    pub fn max_freq(s: String, max_len: i32) -> i32 {
        let mut count = HashMap::new();
        let bytes = s.as_bytes();
        let n = bytes.len();

        for len in 1..=max_len {
            for i in 0..=n - len as usize {
                let sub = &s[i..i + len as usize];
                *count.entry(sub).or_insert(0) += 1;
            }
        }

        *count.values().max().unwrap_or(&0)
    }
}