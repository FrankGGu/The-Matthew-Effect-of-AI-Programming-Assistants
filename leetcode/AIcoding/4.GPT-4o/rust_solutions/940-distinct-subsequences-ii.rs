impl Solution {
    pub fn distinct_subseqii(s: String) -> i32 {
        let mod_val = 1_000_000_007;
        let n = s.len();
        let mut dp = vec![0; n + 1];
        let mut last = vec![-1; 26];

        dp[0] = 1;

        for i in 0..n {
            let c = (s.as_bytes()[i] - b'a') as usize;
            dp[i + 1] = (dp[i] * 2) % mod_val;
            if last[c] != -1 {
                dp[i + 1] = (dp[i + 1] - dp[last[c] as usize]) % mod_val;
            }
            last[c] = i as i32;
        }

        (dp[n] - 1 + mod_val) % mod_val
    }
}