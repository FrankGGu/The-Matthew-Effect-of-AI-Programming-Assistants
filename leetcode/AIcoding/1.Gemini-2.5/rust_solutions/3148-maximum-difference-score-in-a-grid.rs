impl Solution {
    pub fn max_score(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut max_score = i32::MIN;

        // dp[i][j] will store the minimum value in the subgrid grid[0..i][0..j].
        let mut dp = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                if i == 0 && j == 0 {
                    // Base case: first cell
                    dp[0][0] = grid[0][0];
                } else {
                    // Calculate the minimum value in the top-left region
                    // that does not include the current cell (grid[i][j]).
                    // This minimum is used to calculate a potential max_score.
                    let mut min_val_for_diff = i32::MAX;
                    if i > 0 {
                        min_val_for_diff = min_val_for_diff.min(dp[i - 1][j]);
                    }
                    if j > 0 {
                        min_val_for_diff = min_val_for_diff.min(dp[i][j - 1]);
                    }

                    // If there are valid previous cells (i.e., not the first row/column entirely)
                    if min_val_for_diff != i32::MAX {
                        max_score = max_score.max(grid[i][j] - min_val_for_diff);
                    }

                    // Update dp[i][j] with the minimum value in the subgrid grid[0..i][0..j].
                    // This includes grid[i][j] itself and the minimums from its top and left neighbors.
                    dp[i][j] = grid[i][j];
                    if i > 0 {
                        dp[i][j] = dp[i][j].min(dp[i - 1][j]);
                    }
                    if j > 0 {
                        dp[i][j] = dp[i][j].min(dp[i][j - 1]);
                    }
                }
            }
        }

        max_score
    }
}