impl Solution {
    pub fn longest_ideal_string(s: String, k: i32) -> i32 {
        let mut dp = [0; 26];
        for c in s.chars() {
            let idx = (c as u8 - b'a') as usize;
            let mut max_len = 0;
            let start = (idx as i32 - k).max(0) as usize;
            let end = (idx as i32 + k).min(25) as usize;
            for i in start..=end {
                max_len = max_len.max(dp[i]);
            }
            dp[idx] = max_len + 1;
        }
        *dp.iter().max().unwrap()
    }
}