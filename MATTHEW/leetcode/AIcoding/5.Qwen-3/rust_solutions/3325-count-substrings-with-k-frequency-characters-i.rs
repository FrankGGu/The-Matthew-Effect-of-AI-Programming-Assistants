impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn k_freq_substring(s: String, k: i32) -> i32 {
        let k = k as usize;
        let mut count = 0;
        let s = s.as_bytes();

        for i in 0..s.len() {
            let mut freq = HashMap::new();
            for j in i..s.len() {
                *freq.entry(s[j]).or_insert(0) += 1;
                if freq.values().all(|&v| v >= k) {
                    count += 1;
                }
            }
        }

        count
    }
}
}