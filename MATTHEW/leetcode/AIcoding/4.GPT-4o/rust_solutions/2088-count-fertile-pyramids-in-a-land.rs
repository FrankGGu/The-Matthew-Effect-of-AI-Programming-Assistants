impl Solution {
    pub fn count_pyramids(grid: Vec<Vec<i32>>) -> i32 {
        let (m, n) = (grid.len(), grid[0].len());
        let mut dp = vec![vec![0; n]; m];
        let mut count = 0;

        for i in (0..m).rev() {
            for j in (0..n) {
                if grid[i][j] == 1 {
                    dp[i][j] = 1 + if i + 1 < m && j > 0 && j + 1 < n {
                        dp[i + 1][j - 1].min(dp[i + 1][j]).min(dp[i + 1][j + 1])
                    } else {
                        0
                    };
                    count += dp[i][j];
                }
            }
        }

        count
    }
}