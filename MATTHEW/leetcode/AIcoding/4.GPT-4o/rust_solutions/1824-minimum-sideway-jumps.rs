impl Solution {
    pub fn min_side_jumps(obstacles: Vec<i32>) -> i32 {
        let n = obstacles.len();
        let mut dp = vec![vec![i32::MAX; 3]; n];
        dp[0][0] = 0;
        dp[0][1] = 0;
        dp[0][2] = 0;

        for i in 0..n {
            for j in 0..3 {
                if obstacles[i] == j + 1 {
                    continue;
                }
                if i > 0 {
                    dp[i][j] = dp[i - 1][j];
                }
                if j > 0 && obstacles[i] != j && obstacles[i] != j {
                    dp[i][j] = dp[i][j].min(dp[i][j - 1] + 1);
                }
                if j < 2 && obstacles[i] != j + 2 && obstacles[i] != j + 2 {
                    dp[i][j] = dp[i][j].min(dp[i][j + 1] + 1);
                }
            }
        }

        dp[n - 1][0].min(dp[n - 1][1]).min(dp[n - 1][2])
    }
}