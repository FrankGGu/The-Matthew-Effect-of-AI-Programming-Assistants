impl Solution {

use std::cmp::Min;
use std::collections::VecDeque;

impl Solution {
    pub fn min_path_cost(mut grid: Vec<Vec<i32>>, cost: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();

        let mut dp = vec![vec![0; cols]; rows];
        for j in 0..cols {
            dp[0][j] = grid[0][j];
        }

        for i in 1..rows {
            for j in 0..cols {
                let mut min_prev = i32::MAX;
                for k in 0..cols {
                    if dp[i-1][k] + cost[k][j] < min_prev {
                        min_prev = dp[i-1][k] + cost[k][j];
                    }
                }
                dp[i][j] = min_prev + grid[i][j];
            }
        }

        *dp[rows-1].iter().min().unwrap()
    }
}
}