impl Solution {
    pub fn is_possible_to_disconnect_path(grid: Vec<Vec<i32>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();

        // Edge case: If the grid is too small, there are no intermediate cells to flip.
        // (0,0) is the start and (m-1, n-1) is the end.
        // If m*n <= 2, it means:
        // - 1x1 grid: (0,0) is start and end. No intermediate. Cannot disconnect.
        // - 1x2 grid: (0,0) to (0,1). No intermediate. Cannot disconnect.
        // - 2x1 grid: (0,0) to (1,0). No intermediate. Cannot disconnect.
        // In these cases, it's impossible to disconnect with one flip.
        if m * n <= 2 {
            return false;
        }

        // dp[r][c] will store the number of "disjoint" paths from (0,0) to (r,c).
        // We cap this count at 2, as we only care if it's 0, 1, or >= 2.
        // 0: not reachable
        // 1: reachable via a single path (or all paths merge to a single point)
        // 2: reachable via at least two "disjoint" paths
        let mut dp = vec![vec![0; n]; m];

        // Initialize dp[0][0] if the start cell is valid
        if grid[0][0] == 1 {
            dp[0][0] = 1;
        } else {
            // If start cell is 0, no path exists.
            // This will result in dp[m-1][n-1] being 0, which will correctly return true.
        }

        // Fill the DP table
        for r in 0..m {
            for c in 0..n {
                // If the current cell is blocked, it cannot be part of any path
                if grid[r][c] == 0 {
                    continue;
                }

                // Skip (0,0) as it's already initialized
                if r == 0 && c == 0 {
                    continue;
                }

                let mut current_paths = 0;
                // Add paths from the cell above
                if r > 0 {
                    current_paths += dp[r - 1][c];
                }
                // Add paths from the cell to the left
                if c > 0 {
                    current_paths += dp[r][c - 1];
                }

                // Cap the count at 2. If it's 0 or 1, keep it. If it's >=2, set to 2.
                dp[r][c] = current_paths.min(2);
            }
        }

        // The result depends on dp[m-1][n-1]:
        // - If dp[m-1][n-1] == 0: No path exists from (0,0) to (m-1, n-1).
        //   0 flips are needed to disconnect. Return true.
        // - If dp[m-1][n-1] == 1: There is essentially one "disjoint" path.
        //   This means all paths from (0,0) to (m-1, n-1) can be disconnected by flipping one intermediate cell.
        //   Return true.
        // - If dp[m-1][n-1] == 2: There are at least two "disjoint" paths.
        //   This implies that no single intermediate cell can disconnect all paths.
        //   Return false.
        dp[m - 1][n - 1] <= 1
    }
}