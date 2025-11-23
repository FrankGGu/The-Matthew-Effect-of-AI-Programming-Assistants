impl Solution {
    pub fn max_moves(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![0; n]; m];
        let mut max_moves = 0;

        for j in (0..n-1).rev() {
            for i in 0..m {
                let mut current_max = 0;
                for di in -1..=1 {
                    let ni = i as i32 + di;
                    if ni >= 0 && ni < m as i32 && grid[ni as usize][j + 1] > grid[i][j] {
                        current_max = current_max.max(dp[ni as usize][j + 1] + 1);
                    }
                }
                dp[i][j] = current_max;
                if j == 0 {
                    max_moves = max_moves.max(dp[i][j]);
                }
            }
        }

        max_moves
    }
}