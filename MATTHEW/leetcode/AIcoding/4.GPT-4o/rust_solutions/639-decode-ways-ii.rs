impl Solution {
    pub fn num_decodings(s: String) -> i32 {
        let n = s.len();
        let mut dp = vec![0; n + 1];
        dp[0] = 1;

        let s_bytes = s.as_bytes();
        for i in 1..=n {
            if s_bytes[i - 1] != b'0' {
                dp[i] += dp[i - 1];
            }
            if i > 1 {
                let first = s_bytes[i - 2] - b'0';
                let second = s_bytes[i - 1] - b'0';
                if (first == 1) || (first == 2 && second <= 6) {
                    dp[i] += dp[i - 2];
                } else if first == '*' {
                    dp[i] += 9 * dp[i - 2];
                } else if first == 1 && second == '*' {
                    dp[i] += dp[i - 2];
                } else if first == 2 && second == '*' {
                    dp[i] += 6 * dp[i - 2];
                }
            }
        }

        dp[n] as i32
    }
}