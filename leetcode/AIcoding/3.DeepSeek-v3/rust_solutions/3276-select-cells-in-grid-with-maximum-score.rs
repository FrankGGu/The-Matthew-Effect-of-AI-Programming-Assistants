impl Solution {
    pub fn max_score(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![i32::MIN; n]; m];
        let mut max_score = i32::MIN;

        for i in (0..m).rev() {
            for j in (0..n).rev() {
                let mut current_max = i32::MIN;
                if i + 1 < m {
                    current_max = current_max.max(dp[i + 1][j]);
                }
                if j + 1 < n {
                    current_max = current_max.max(dp[i][j + 1]);
                }
                if current_max != i32::MIN {
                    dp[i][j] = current_max + grid[i][j];
                } else {
                    dp[i][j] = grid[i][j];
                }
                if i != 0 || j != 0 {
                    max_score = max_score.max(current_max - grid[i][j]);
                }
            }
        }

        max_score
    }
}