impl Solution {
    pub fn min_path_cost(grid: Vec<Vec<i32>>, move_cost: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = grid.clone();

        for i in 1..m {
            for j in 0..n {
                dp[i][j] += (0..n).map(|k| dp[i-1][k] + move_cost[k][j]).min().unwrap();
            }
        }

        dp[m-1].iter().cloned().min().unwrap()
    }
}