use std::cmp;

impl Solution {
    pub fn min_cost_to_reach_every_position(costs: Vec<Vec<i32>>) -> i32 {
        let m = costs.len();
        let n = costs[0].len();
        let mut dp = vec![vec![0; n]; m];

        dp[0][0] = costs[0][0];

        for j in 1..n {
            dp[0][j] = dp[0][j - 1] + costs[0][j];
        }

        for i in 1..m {
            dp[i][0] = dp[i - 1][0] + costs[i][0];
        }

        for i in 1..m {
            for j in 1..n {
                dp[i][j] = cmp::min(dp[i - 1][j], dp[i][j - 1]) + costs[i][j];
            }
        }

        dp[m - 1][n - 1]
    }
}