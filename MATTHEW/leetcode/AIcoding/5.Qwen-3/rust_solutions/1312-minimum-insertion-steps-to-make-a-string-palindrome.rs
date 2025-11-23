struct Solution;

impl Solution {
    pub fn min_insertions(s: String) -> i32 {
        let n = s.len();
        let mut dp = vec![vec![0; n]; n];

        for i in (0..n).rev() {
            for j in (i + 1)..n {
                if s.as_bytes()[i] == s.as_bytes()[j] {
                    dp[i][j] = dp[i + 1][j - 1];
                } else {
                    dp[i][j] = 1 + std::cmp::min(dp[i + 1][j], dp[i][j - 1]);
                }
            }
        }

        dp[0][n - 1]
    }
}