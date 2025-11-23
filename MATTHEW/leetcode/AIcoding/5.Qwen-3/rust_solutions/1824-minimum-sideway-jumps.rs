impl Solution {

use std::cmp::min;

impl Solution {
    pub fn min_sideways_jumps(n: i32, roads: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut dp = vec![vec![0; 3]; n];

        for i in 0..n {
            for j in 0..3 {
                if i == 0 {
                    dp[i][j] = if j == 0 { 0 } else { 1 };
                } else {
                    dp[i][j] = dp[i - 1][j];
                    if roads[i][j] == 1 {
                        dp[i][j] = min(dp[i][j], dp[i - 1][(j + 1) % 3] + 1);
                        dp[i][j] = min(dp[i][j], dp[i - 1][(j + 2) % 3] + 1);
                    }
                }
            }
        }

        min(dp[n - 1][0], min(dp[n - 1][1], dp[n - 1][2]))
    }
}
}