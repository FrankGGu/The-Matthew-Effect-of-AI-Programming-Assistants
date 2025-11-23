impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn k_inverse_pairs(n: i32, k: i32) -> i32 {
        let mod_val = 10i32.pow(9) + 7;
        let n = n as usize;
        let k = k as usize;
        let mut dp = vec![vec![0; k + 1]; n + 1];
        dp[0][0] = 1;

        for i in 1..=n {
            for j in 0..=k {
                for m in 0..=i {
                    if j >= m {
                        dp[i][j] += dp[i - 1][j - m];
                        dp[i][j] %= mod_val;
                    }
                }
            }
        }

        dp[n][k]
    }
}
}