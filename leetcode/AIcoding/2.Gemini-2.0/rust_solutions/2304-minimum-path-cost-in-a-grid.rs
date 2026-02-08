impl Solution {
    pub fn min_path_cost(grid: Vec<Vec<i32>>, move_cost: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![i32::MAX; n]; m];

        for j in 0..n {
            dp[0][j] = grid[0][j];
        }

        for i in 0..m - 1 {
            for j in 0..n {
                for next_j in 0..n {
                    let current_val = grid[i][j];
                    let move_c = move_cost[current_val as usize][next_j];
                    dp[i + 1][next_j] = dp[i + 1][next_j].min(dp[i][j] + move_c + grid[i + 1][next_j]);
                }
            }
        }

        let mut min_cost = i32::MAX;
        for j in 0..n {
            min_cost = min_cost.min(dp[m - 1][j]);
        }

        min_cost
    }
}