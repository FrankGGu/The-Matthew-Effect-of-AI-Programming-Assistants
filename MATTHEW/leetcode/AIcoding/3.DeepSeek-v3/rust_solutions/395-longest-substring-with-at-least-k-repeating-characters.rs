use std::collections::HashMap;

impl Solution {
    pub fn longest_substring(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let k = k as usize;
        let mut max_len = 0;

        for t in 1..=26 {
            let mut left = 0;
            let mut right = 0;
            let mut cnt = HashMap::new();
            let mut unique = 0;
            let mut k_or_more = 0;

            while right < n {
                if unique <= t {
                    let ch = s[right];
                    *cnt.entry(ch).or_insert(0) += 1;
                    if cnt[&ch] == 1 {
                        unique += 1;
                    }
                    if cnt[&ch] == k {
                        k_or_more += 1;
                    }
                    right += 1;
                } else {
                    let ch = s[left];
                    if cnt[&ch] == 1 {
                        unique -= 1;
                    }
                    if cnt[&ch] == k {
                        k_or_more -= 1;
                    }
                    *cnt.entry(ch).or_insert(0) -= 1;
                    left += 1;
                }
                if unique == t && k_or_more == t {
                    max_len = max_len.max(right - left);
                }
            }
        }
        max_len as i32
    }
}