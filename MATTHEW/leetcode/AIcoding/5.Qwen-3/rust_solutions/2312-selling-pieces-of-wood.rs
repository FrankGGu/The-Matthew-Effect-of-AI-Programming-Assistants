impl Solution {

use std::cmp::max;

impl Solution {
    pub fn max_profit(n: i32, m: i32, prices: Vec<Vec<i32>>) -> i32 {
        let mut dp = vec![vec![0; m as usize]; n as usize];

        for price in prices {
            let i = price[0] as usize;
            let j = price[1] as usize;
            let p = price[2];
            dp[i][j] = p;
        }

        for i in 0..n as usize {
            for j in 0..m as usize {
                if i == 0 && j == 0 {
                    continue;
                }

                let mut max_val = 0;

                for k in 0..i {
                    max_val = max(max_val, dp[k][j] + dp[i - k - 1][j]);
                }

                for l in 0..j {
                    max_val = max(max_val, dp[i][l] + dp[i][j - l - 1]);
                }

                dp[i][j] = max(dp[i][j], max_val);
            }
        }

        dp[n as usize - 1][m as usize - 1]
    }
}
}