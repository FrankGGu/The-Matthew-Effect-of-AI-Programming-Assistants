impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_ways(n: i32) -> i32 {
        let n = n as usize;
        let mut dp = vec![vec![0; n]; n];
        dp[0][0] = 1;

        for step in 1..n {
            for pos in 0..n {
                dp[step][pos] = dp[step - 1][pos];
                if pos > 0 {
                    dp[step][pos] += dp[step - 1][pos - 1];
                }
                if pos < n - 1 {
                    dp[step][pos] += dp[step - 1][pos + 1];
                }
            }
        }

        dp[n - 1][0]
    }
}
}