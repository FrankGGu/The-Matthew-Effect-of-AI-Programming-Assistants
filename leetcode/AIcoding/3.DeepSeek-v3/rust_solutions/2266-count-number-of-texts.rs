impl Solution {
    pub fn count_texts(pressed_keys: String) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let s = pressed_keys.as_bytes();
        let n = s.len();
        let mut dp = vec![0; n + 1];
        dp[0] = 1;

        for i in 1..=n {
            dp[i] = dp[i - 1];
            if i >= 2 && s[i - 1] == s[i - 2] {
                dp[i] = (dp[i] + dp[i - 2]) % MOD;
                if i >= 3 && s[i - 1] == s[i - 3] {
                    dp[i] = (dp[i] + dp[i - 3]) % MOD;
                    if (s[i - 1] == b'7' || s[i - 1] == b'9') && i >= 4 && s[i - 1] == s[i - 4] {
                        dp[i] = (dp[i] + dp[i - 4]) % MOD;
                    }
                }
            }
        }

        dp[n] as i32
    }
}