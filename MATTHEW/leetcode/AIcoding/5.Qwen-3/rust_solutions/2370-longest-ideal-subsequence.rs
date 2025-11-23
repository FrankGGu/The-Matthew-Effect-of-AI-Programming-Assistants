impl Solution {

use std::cmp;

impl Solution {
    pub fn longest_ideal_string(s: String, k: i32) -> i32 {
        let mut dp = [0; 26];
        for c in s.chars() {
            let idx = (c as u8 - b'a') as usize;
            let mut max_len = 0;
            for i in 0..26 {
                if (i as i32 - idx as i32).abs() <= k {
                    max_len = cmp::max(max_len, dp[i]);
                }
            }
            dp[idx] = max_len + 1;
        }
        *dp.iter().max().unwrap()
    }
}
}