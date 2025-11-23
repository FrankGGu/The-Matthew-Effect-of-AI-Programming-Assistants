impl Solution {
    pub fn find_minimum_moves(m: Vec<Vec<i32>>) -> i32 {
        let n = m.len();
        let mut dp = vec![vec![i32::MAX; n]; n];
        dp[0][0] = 0;

        for i in 0..n {
            for j in 0..n {
                if dp[i][j] == i32::MAX {
                    continue;
                }

                if i + 1 < n {
                    dp[i + 1][j] = dp[i + 1][j].min(dp[i][j] + m[i + 1][j]);
                }
                if j + 1 < n {
                    dp[i][j + 1] = dp[i][j + 1].min(dp[i][j] + m[i][j + 1]);
                }
            }
        }

        dp[n - 1][n - 1]
    }
}