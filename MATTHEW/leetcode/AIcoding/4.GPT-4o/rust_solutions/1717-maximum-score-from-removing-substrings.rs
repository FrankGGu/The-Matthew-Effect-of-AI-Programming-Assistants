impl Solution {
    pub fn maximum_score(s: String, t: String, x: i32) -> i32 {
        let mut dp = vec![vec![0; t.len() + 1]; s.len() + 1];

        for i in 1..=s.len() {
            for j in 1..=t.len() {
                if s.as_bytes()[i - 1] == t.as_bytes()[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + x;
                }
                dp[i][j] = dp[i][j].max(dp[i - 1][j]);
                dp[i][j] = dp[i][j].max(dp[i][j - 1]);
            }
        }

        dp[s.len()][t.len()]
    }
}