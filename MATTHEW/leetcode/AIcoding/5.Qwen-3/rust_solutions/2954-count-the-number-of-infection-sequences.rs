impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn number_of_infection_sequences(n: i32, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let mut dp = vec![vec![0; n + 1]; n + 1];
        for i in 1..=n {
            dp[1][i] = 1;
        }
        for m in 2..=n {
            for i in 1..=n {
                for j in 1..=i {
                    dp[m][i] += dp[m - 1][j] * (i - j) as i32;
                }
            }
        }
        dp[k][n]
    }
}
}