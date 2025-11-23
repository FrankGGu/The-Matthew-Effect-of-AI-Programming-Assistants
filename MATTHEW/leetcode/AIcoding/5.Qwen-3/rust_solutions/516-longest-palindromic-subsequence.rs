struct Solution;

impl Solution {
    pub fn longest_palindromic_subsequence(s: String) -> i32 {
        let n = s.len();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = 1;
        }

        for length in 2..=n {
            for i in 0..=n - length {
                let j = i + length - 1;
                if s.chars().nth(i) == s.chars().nth(j) {
                    if length == 2 {
                        dp[i][j] = 2;
                    } else {
                        dp[i][j] = dp[i + 1][j - 1] + 2;
                    }
                } else {
                    dp[i][j] = std::cmp::max(dp[i + 1][j], dp[i][j - 1]);
                }
            }
        }

        dp[0][n - 1] as i32
    }
}