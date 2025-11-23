impl Solution {

use std::cmp;

impl Solution {
    pub fn super_egg_drop(n: i32, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let mut dp = vec![vec![0; k + 1]; n + 1];

        for i in 1..=n {
            for j in 1..=k {
                dp[i][j] = dp[i][j - 1] + dp[i - 1][j - 1] + 1;
                if dp[i][j] >= k {
                    return i as i32;
                }
            }
        }

        n as i32
    }
}
}