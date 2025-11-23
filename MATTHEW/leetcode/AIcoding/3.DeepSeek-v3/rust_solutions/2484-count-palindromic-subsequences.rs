impl Solution {
    pub fn count_palindromic_subsequences(s: String) -> i32 {
        let s: Vec<char> = s.chars().collect();
        let n = s.len();
        let mod_num = 1_000_000_007;
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = 1;
        }

        for len in 2..=n {
            for i in 0..=n-len {
                let j = i + len - 1;
                if s[i] == s[j] {
                    let mut left = i + 1;
                    let mut right = j - 1;
                    while left <= right && s[left] != s[i] {
                        left += 1;
                    }
                    while left <= right && s[right] != s[i] {
                        right -= 1;
                    }
                    if left > right {
                        dp[i][j] = dp[i+1][j-1] * 2 + 2;
                    } else if left == right {
                        dp[i][j] = dp[i+1][j-1] * 2 + 1;
                    } else {
                        dp[i][j] = dp[i+1][j-1] * 2 - dp[left+1][right-1];
                    }
                } else {
                    dp[i][j] = dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1];
                }
                dp[i][j] = if dp[i][j] < 0 { dp[i][j] + mod_num } else { dp[i][j] % mod_num };
            }
        }

        dp[0][n-1]
    }
}