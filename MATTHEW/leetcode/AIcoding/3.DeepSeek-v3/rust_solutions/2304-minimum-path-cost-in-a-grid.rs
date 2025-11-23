impl Solution {
    pub fn min_path_cost(grid: Vec<Vec<i32>>, move_cost: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![0; n]; m];
        for j in 0..n {
            dp[0][j] = grid[0][j];
        }
        for i in 1..m {
            for j in 0..n {
                let mut min_cost = i32::MAX;
                for k in 0..n {
                    let val = grid[i-1][k];
                    let cost = dp[i-1][k] + move_cost[val as usize][j];
                    if cost < min_cost {
                        min_cost = cost;
                    }
                }
                dp[i][j] = min_cost + grid[i][j];
            }
        }
        *dp[m-1].iter().min().unwrap()
    }
}