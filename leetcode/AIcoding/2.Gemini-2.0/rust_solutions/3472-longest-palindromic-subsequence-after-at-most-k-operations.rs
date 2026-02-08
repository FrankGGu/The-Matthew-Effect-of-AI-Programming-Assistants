impl Solution {
    pub fn longest_palindrome_subsequence(s: String, k: i32) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = 1;
        }

        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                if s_bytes[i] == s_bytes[j] {
                    dp[i][j] = dp[i + 1][j - 1] + 2;
                } else {
                    dp[i][j] = dp[i + 1][j].max(dp[i][j - 1]);
                }
            }
        }

        let longest_palindrome = dp[0][n - 1];
        if n as i32 - longest_palindrome <= k {
            return n as i32;
        } else {
            return longest_palindrome + k;
        }
    }
}