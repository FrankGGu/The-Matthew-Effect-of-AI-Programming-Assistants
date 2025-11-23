impl Solution {
    pub fn count_texts(pressed_keys: String) -> i32 {
        let n = pressed_keys.len();
        let keys: Vec<char> = pressed_keys.chars().collect();
        let mut dp = vec![0; n + 1];
        dp[0] = 1;
        let mod_val = 1_000_000_007;

        for i in 1..=n {
            dp[i] = dp[i - 1];
            if i >= 2 && keys[i - 1] == keys[i - 2] {
                dp[i] = (dp[i] + dp[i - 2]) % mod_val;
                if i >= 3 && keys[i - 1] == keys[i - 3] {
                    dp[i] = (dp[i] + dp[i - 3]) % mod_val;
                    if (keys[i - 1] == '7' || keys[i - 1] == '9') && i >= 4 && keys[i - 1] == keys[i - 4] {
                        dp[i] = (dp[i] + dp[i - 4]) % mod_val;
                    }
                }
            }
        }

        dp[n] as i32
    }
}