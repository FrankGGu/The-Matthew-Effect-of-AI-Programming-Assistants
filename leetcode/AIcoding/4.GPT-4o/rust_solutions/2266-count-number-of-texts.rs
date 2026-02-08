pub fn count_texts(pressed_keys: String) -> i32 {
    const MOD: i32 = 1_000_000_007;
    let n = pressed_keys.len();
    let mut dp = vec![0; n + 1];
    dp[0] = 1;

    for i in 1..=n {
        let key = pressed_keys.as_bytes()[i - 1] - b'0';
        dp[i] = (dp[i] + dp[i - 1]) % MOD;

        if key == 7 || key == 9 {
            if i >= 2 && pressed_keys.as_bytes()[i - 1] == pressed_keys.as_bytes()[i - 2] {
                dp[i] = (dp[i] + dp[i - 2]) % MOD;
            }
            if i >= 3 && pressed_keys.as_bytes()[i - 1] == pressed_keys.as_bytes()[i - 2] && pressed_keys.as_bytes()[i - 2] == pressed_keys.as_bytes()[i - 3] {
                dp[i] = (dp[i] + dp[i - 3]) % MOD;
            }
        } else {
            if i >= 2 && pressed_keys.as_bytes()[i - 1] == pressed_keys.as_bytes()[i - 2] {
                dp[i] = (dp[i] + dp[i - 2]) % MOD;
            }
        }
    }

    dp[n]
}