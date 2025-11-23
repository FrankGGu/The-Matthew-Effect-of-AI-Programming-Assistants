impl Solution {
    pub fn longest_ideal_string(s: String, k: i32) -> i32 {
        let mut dp = vec![0; 128];
        let s_bytes = s.as_bytes();

        for &c in s_bytes {
            let c_index = c as usize;
            let lower_bound = c_index.saturating_sub(k as usize);
            let upper_bound = (c_index + k as usize).min(127);
            let max_prev = (lower_bound..=upper_bound).map(|i| dp[i]).max().unwrap_or(0);
            dp[c_index] = max_prev + 1;
        }

        dp.into_iter().max().unwrap_or(0)
    }
}