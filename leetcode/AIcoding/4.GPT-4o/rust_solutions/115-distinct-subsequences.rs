impl Solution {
    pub fn num_distinct(s: String, t: String) -> i32 {
        let m = s.len();
        let n = t.len();
        let mut dp = vec![vec![0; n + 1]; m + 1];

        for j in 0..=n {
            dp[0][j] = if j == 0 { 1 } else { 0 };
        }

        for i in 1..=m {
            dp[i][0] = 1;
            for j in 1..=n {
                dp[i][j] = dp[i - 1][j];
                if s.as_bytes()[i - 1] == t.as_bytes()[j - 1] {
                    dp[i][j] += dp[i - 1][j - 1];
                }
            }
        }

        dp[m][n]
    }
}