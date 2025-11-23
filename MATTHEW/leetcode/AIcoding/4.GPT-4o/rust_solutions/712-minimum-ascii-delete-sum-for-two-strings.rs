impl Solution {
    pub fn minimum_delete_sum(s1: String, s2: String) -> i32 {
        let m = s1.len();
        let n = s2.len();
        let mut dp = vec![vec![0; n + 1]; m + 1];

        for i in 1..=m {
            dp[i][0] = dp[i - 1][0] + s1.as_bytes()[i - 1] as i32;
        }
        for j in 1..=n {
            dp[0][j] = dp[0][j - 1] + s2.as_bytes()[j - 1] as i32;
        }

        for i in 1..=m {
            for j in 1..=n {
                if s1.as_bytes()[i - 1] == s2.as_bytes()[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1];
                } else {
                    dp[i][j] = (dp[i - 1][j] + s1.as_bytes()[i - 1] as i32)
                        .min(dp[i][j - 1] + s2.as_bytes()[j - 1] as i32);
                }
            }
        }

        dp[m][n]
    }
}