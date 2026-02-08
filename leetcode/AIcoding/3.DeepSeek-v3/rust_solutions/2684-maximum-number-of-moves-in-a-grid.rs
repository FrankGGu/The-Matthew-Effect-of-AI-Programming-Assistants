impl Solution {
    pub fn max_moves(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![0; n]; m];
        let mut max_moves = 0;

        for j in (0..n-1).rev() {
            for i in 0..m {
                let current_val = grid[i][j];
                let next_j = j + 1;
                let mut max_next = 0;

                if i > 0 && grid[i-1][next_j] > current_val {
                    max_next = max_next.max(dp[i-1][next_j]);
                }
                if grid[i][next_j] > current_val {
                    max_next = max_next.max(dp[i][next_j]);
                }
                if i < m - 1 && grid[i+1][next_j] > current_val {
                    max_next = max_next.max(dp[i+1][next_j]);
                }

                if max_next > 0 || next_j == n - 1 {
                    dp[i][j] = max_next + 1;
                    if j == 0 {
                        max_moves = max_moves.max(dp[i][j]);
                    }
                }
            }
        }

        max_moves
    }
}