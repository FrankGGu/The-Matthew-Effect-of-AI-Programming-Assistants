impl Solution {
    pub fn num_decodings(s: String) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut dp = vec![0; n + 1];
        dp[0] = 1;
        dp[1] = match s[0] {
            b'0' => 0,
            b'*' => 9,
            _ => 1,
        };
        for i in 2..=n {
            let first = s[i - 1];
            let second = s[i - 2];
            if first == b'*' {
                dp[i] += 9 * dp[i - 1];
            } else if first != b'0' {
                dp[i] += dp[i - 1];
            }
            if second == b'*' {
                if first == b'*' {
                    dp[i] += 15 * dp[i - 2];
                } else if first <= b'6' {
                    dp[i] += 2 * dp[i - 2];
                } else {
                    dp[i] += dp[i - 2];
                }
            } else if second == b'1' {
                if first == b'*' {
                    dp[i] += 9 * dp[i - 2];
                } else {
                    dp[i] += dp[i - 2];
                }
            } else if second == b'2' {
                if first == b'*' {
                    dp[i] += 6 * dp[i - 2];
                } else if first <= b'6' {
                    dp[i] += dp[i - 2];
                }
            }
            dp[i] %= 1_000_000_007;
        }
        dp[n]
    }
}