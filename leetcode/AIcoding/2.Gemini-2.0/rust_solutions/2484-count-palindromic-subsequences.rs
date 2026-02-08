impl Solution {
    pub fn count_palindromic_subsequences(s: String) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let MOD: i64 = 1_000_000_007;

        let mut dp = vec![vec![vec![0; 4]; n]; n];

        for i in 0..n {
            for j in 0..4 {
                if (s[i] as i32 - '0' as i32) == j {
                    dp[i][i][j] = 1;
                }
            }
        }

        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                for k in 0..4 {
                    if (s[i] as i32 - '0' as i32) == k && (s[j] as i32 - '0' as i32) == k {
                        dp[i][j][k] = 2;
                        for l in i + 1..j {
                            for m in 0..4 {
                                dp[i][j][k] = (dp[i][j][k] + dp[l][l][m]) % MOD;
                            }
                        }
                        for l in i + 1..j {
                            for r in l + 1..=j - 1 {
                                for m in 0..4 {
                                    dp[i][j][k] = (dp[i][j][k] + dp[l][r][m]) % MOD;
                                }
                            }
                        }
                    } else if (s[i] as i32 - '0' as i32) == k {
                        dp[i][j][k] = dp[i][j - 1][k];
                    } else if (s[j] as i32 - '0' as i32) == k {
                        dp[i][j][k] = dp[i + 1][j][k];
                    } else {
                        dp[i][j][k] = dp[i + 1][j - 1][k];
                    }
                    dp[i][j][k] %= MOD;
                }
            }
        }

        let mut ans: i64 = 0;
        for k in 0..4 {
            ans = (ans + dp[0][n - 1][k]) % MOD;
        }

        ans as i32
    }
}