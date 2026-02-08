impl Solution {
    pub fn count_palindromic_subsequences(s: String) -> i32 {
        let n = s.len();
        let s = s.as_bytes();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = 1;
        }

        for length in 2..=n {
            for start in 0..=n - length {
                let end = start + length - 1;
                if s[start] == s[end] {
                    let mut count = 2;
                    let mut left = start + 1;
                    let mut right = end - 1;
                    while left <= right {
                        if s[left] == s[start] {
                            count += 1;
                            left += 1;
                        } else if s[right] == s[end] {
                            count += 1;
                            right -= 1;
                        } else {
                            left += 1;
                            right -= 1;
                        }
                    }
                    dp[start][end] = dp[start + 1][end] + dp[start][end - 1] + count - 1;
                } else {
                    dp[start][end] = dp[start + 1][end] + dp[start][end - 1] - dp[start + 1][end - 1];
                }
            }
        }

        dp[0][n - 1]
    }
}