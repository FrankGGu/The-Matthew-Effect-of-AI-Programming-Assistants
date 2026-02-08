impl Solution {
    pub fn count_palindromic_subsequences(s: String) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let MOD: i64 = 1_000_000_007;

        let mut dp = vec![vec![vec![0; 4]; n]; n];

        for len in 1..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                for k in 0..4 {
                    let ch = match k {
                        0 => 'a',
                        1 => 'b',
                        2 => 'c',
                        3 => 'd',
                        _ => unreachable!(),
                    };

                    if len == 1 {
                        if s[i] == ch {
                            dp[i][j][k] = 1;
                        } else {
                            dp[i][j][k] = 0;
                        }
                    } else {
                        if s[i] == ch && s[j] == ch {
                            dp[i][j][k] = 2;
                            for l in 0..4 {
                                dp[i][j][k] = (dp[i][j][k] + dp[i + 1][j - 1][l]) % MOD;
                            }
                        } else if s[i] == ch {
                            dp[i][j][k] = dp[i][j - 1][k];
                        } else if s[j] == ch {
                            dp[i][j][k] = dp[i + 1][j][k];
                        } else {
                            dp[i][j][k] = dp[i + 1][j - 1][k];
                        }
                    }
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

struct Solution;