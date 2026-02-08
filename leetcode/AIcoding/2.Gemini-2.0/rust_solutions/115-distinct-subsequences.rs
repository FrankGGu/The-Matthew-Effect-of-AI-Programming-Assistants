impl Solution {
    pub fn num_distinct(s: String, t: String) -> i32 {
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();
        let m = s_bytes.len();
        let n = t_bytes.len();

        let mut dp = vec![vec![0; m + 1]; n + 1];

        for j in 0..=m {
            dp[0][j] = 1;
        }

        for i in 1..=n {
            for j in 1..=m {
                if t_bytes[i - 1] == s_bytes[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + dp[i][j - 1];
                } else {
                    dp[i][j] = dp[i][j - 1];
                }
            }
        }

        dp[n][m]
    }
}