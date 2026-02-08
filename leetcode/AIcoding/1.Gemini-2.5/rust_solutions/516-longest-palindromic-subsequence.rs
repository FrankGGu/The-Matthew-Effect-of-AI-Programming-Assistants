impl Solution {
    pub fn longest_palindrome_subseq(s: String) -> i32 {
        let n = s.len();
        if n == 0 {
            return 0;
        }

        let chars: Vec<char> = s.chars().collect();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = 1;
        }

        for len in 2..=n {
            for i in 0..=(n - len) {
                let j = i + len - 1;
                if chars[i] == chars[j] {
                    if len == 2 {
                        dp[i][j] = 2;
                    } else {
                        dp[i][j] = 2 + dp[i + 1][j - 1];
                    }
                } else {
                    dp[i][j] = dp[i + 1][j].max(dp[i][j - 1]);
                }
            }
        }

        dp[0][n - 1]
    }
}