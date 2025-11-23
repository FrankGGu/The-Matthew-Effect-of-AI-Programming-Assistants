struct Solution;

impl Solution {
    pub fn num_perms_divide(s: &str) -> i32 {
        let n = s.len();
        let mod_val = 10_i32.pow(9) + 7;
        let mut dp = vec![vec![0; n + 1]; n + 1];

        for i in 0..=n {
            dp[i][0] = 1;
        }

        for i in 1..=n {
            for j in 1..=i {
                if s.as_bytes()[i - 1] == b'D' {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % mod_val;
                    if j > 1 {
                        dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % mod_val;
                    }
                } else {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % mod_val;
                    if j < i {
                        dp[i][j] = (dp[i][j] + dp[i - 1][j]) % mod_val;
                    }
                }
            }
        }

        dp[n][0]
    }
}