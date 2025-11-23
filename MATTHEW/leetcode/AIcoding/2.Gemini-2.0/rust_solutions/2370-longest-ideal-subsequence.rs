impl Solution {
    pub fn longest_ideal_string(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let mut dp = vec![0; 26];
        for &c in s {
            let idx = (c - b'a') as usize;
            let mut max_len = 0;
            for i in 0..26 {
                if (i as i32 - idx as i32).abs() <= k {
                    max_len = max_len.max(dp[i]);
                }
            }
            dp[idx] = max_len + 1;
        }
        *dp.iter().max().unwrap()
    }
}