impl Solution {
    pub fn num_perms_di_sequence(s: String) -> i32 {
        let n = s.len();
        let mut dp = vec![vec![0; n + 1]; n + 1];
        for j in 0..=n {
            dp[0][j] = 1;
        }

        let s_bytes = s.as_bytes();

        for i in 1..=n {
            for j in 0..=i {
                if s_bytes[i - 1] == b'I' {
                    for k in 0..j {
                        dp[i][j] = (dp[i][j] + dp[i - 1][k]) % 1_000_000_007;
                    }
                } else {
                    for k in j..i {
                        dp[i][j] = (dp[i][j] + dp[i - 1][k]) % 1_000_000_007;
                    }
                }
            }
        }

        let mut ans = 0;
        for j in 0..=n {
            ans = (ans + dp[n][j]) % 1_000_000_007;
        }

        ans
    }
}