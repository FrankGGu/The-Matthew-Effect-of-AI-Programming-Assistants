impl Solution {

use std::cmp::max;

impl Solution {
    pub fn max_good_subsequence(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut dp = vec![vec![-1; 26]; n];
        let mut res = 0;

        for i in 0..n {
            for j in 0..26 {
                if s[i] as u8 - b'a' == j as u8 {
                    dp[i][j] = 1;
                }
            }

            for j in 0..26 {
                if dp[i][j] == -1 {
                    continue;
                }

                for l in 0..26 {
                    if s[i] as u8 - b'a' != l as u8 {
                        if dp[i][j] + 1 > dp[i][l] {
                            dp[i][l] = dp[i][j] + 1;
                        }
                    }
                }

                res = max(res, dp[i][j]);
            }
        }

        res
    }
}
}