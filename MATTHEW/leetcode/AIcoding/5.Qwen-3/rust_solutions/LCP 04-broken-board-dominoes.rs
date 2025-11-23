impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn num_tilings(mut m: i32) -> i32 {
        if m == 1 {
            return 1;
        }
        if m == 2 {
            return 2;
        }
        let mut dp = vec![0; (m + 1) as usize];
        dp[0] = 1;
        dp[1] = 1;
        dp[2] = 2;
        for i in 3..(m + 1) {
            dp[i as usize] = (2 * dp[(i - 1) as usize] + dp[(i - 3) as usize]) % 1000000007;
        }
        dp[m as usize]
    }
}
}