impl Solution {
    pub fn unique_paths_with_obstacles(obstacle_grid: Vec<Vec<i32>>) -> i32 {
        let m = obstacle_grid.len();
        let n = obstacle_grid[0].len();

        // If the starting cell itself is an obstacle, there are no paths.
        if obstacle_grid[0][0] == 1 {
            return 0;
        }

        // Create a DP table to store the number of unique paths to each cell.
        // Initialize all cells to 0.
        let mut dp = vec![vec![0; n]; m];

        // The starting cell has 1 way to reach it (itself).
        dp[0][0] = 1;

        // Fill the first row of the DP table.
        // A cell in the first row can only be reached from its left neighbor.
        // If the current cell or any cell to its left is an obstacle, it cannot be reached.
        for j in 1..n {
            if obstacle_grid[0][j] == 0 && dp[0][j - 1] == 1 {
                dp[0][j] = 1;
            }
        }

        // Fill the first column of the DP table.
        // A cell in the first column can only be reached from its top neighbor.
        // If the current cell or any cell above it is an obstacle, it cannot be reached.
        for i in 1..m {
            if obstacle_grid[i][0] == 0 && dp[i - 1][0] == 1 {
                dp[i][0] = 1;
            }
        }

        // Fill the rest of the DP table.
        // A cell (i, j) can be reached from (i-1, j) (downward move) or (i, j-1) (rightward move).
        // If the current cell is an obstacle, dp[i][j] remains 0.
        for i in 1..m {
            for j in 1..n {
                if obstacle_grid[i][j] == 0 {
                    dp[i][j] = dp[i - 1][j] + dp[i][j - 1];
                }
            }
        }

        // The result is the number of paths to the bottom-right cell.
        dp[m - 1][n - 1]
    }
}