impl Solution {

use std::cmp::max;

struct Solution {}

impl Solution {
    pub fn max_money(rooms: Vec<Vec<i32>>) -> i32 {
        let m = rooms.len();
        let n = rooms[0].len();
        let mut dp = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                if i == 0 && j == 0 {
                    dp[i][j] = rooms[i][j];
                } else if i == 0 {
                    dp[i][j] = dp[i][j - 1] + rooms[i][j];
                } else if j == 0 {
                    dp[i][j] = dp[i - 1][j] + rooms[i][j];
                } else {
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]) + rooms[i][j];
                }
            }
        }

        dp[m - 1][n - 1]
    }
}
}