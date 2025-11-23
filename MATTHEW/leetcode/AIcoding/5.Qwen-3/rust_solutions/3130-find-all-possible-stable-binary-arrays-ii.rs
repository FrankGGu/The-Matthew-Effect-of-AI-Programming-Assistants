impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_stable_binary_arrays(mut n: i32, k: i32) -> i32 {
        let mut memo = HashMap::new();
        let mut dp = vec![vec![0; 2]; n as usize + 1];
        dp[0][0] = 1;
        dp[0][1] = 1;

        for i in 1..n as usize {
            dp[i][0] = (dp[i - 1][0] + dp[i - 1][1]) % 1_000_000_007;
            dp[i][1] = dp[i - 1][0] % 1_000_000_007;
        }

        let mut result = 0;
        for i in 0..=n as usize {
            if i >= k as usize {
                result = (result + dp[i][0] * dp[n as usize - i][0]) % 1_000_000_007;
            }
        }

        result
    }
}
}