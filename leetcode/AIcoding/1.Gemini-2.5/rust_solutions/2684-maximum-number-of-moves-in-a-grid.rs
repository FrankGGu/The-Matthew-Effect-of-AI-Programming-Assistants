impl Solution {
    pub fn max_moves(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();

        let mut dp = vec![vec![-1; cols]; rows];

        let mut max_total_moves = 0;

        for r in 0..rows {
            dp[r][0] = 0;
        }

        for c in 1..cols {
            for r in 0..rows {
                for dr in -1..=1 {
                    let r_prev = r as isize + dr;

                    if r_prev >= 0 && r_prev < rows as isize {
                        let r_prev = r_prev as usize;

                        if dp[r_prev][c - 1] != -1 && grid[r][c] > grid[r_prev][c - 1] {
                            dp[r][c] = dp[r][c].max(1 + dp[r_prev][c - 1]);
                            max_total_moves = max_total_moves.max(dp[r][c]);
                        }
                    }
                }
            }
        }

        max_total_moves
    }
}