impl Solution {

use std::cmp;

impl Solution {
    pub fn longest_palindromic_subsequence(s: String, k: i32) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = 1;
        }

        for length in 2..=n {
            for i in 0..(n - length + 1) {
                let j = i + length - 1;
                if s[i] == s[j] {
                    dp[i][j] = 2 + dp[i + 1][j - 1];
                } else {
                    dp[i][j] = cmp::max(dp[i + 1][j], dp[i][j - 1]);
                }
            }
        }

        let mut result = 0;
        for i in 0..n {
            for j in i..n {
                if dp[i][j] >= (j - i + 1 - k as usize) {
                    result = cmp::max(result, dp[i][j]);
                }
            }
        }

        result as i32
    }
}
}