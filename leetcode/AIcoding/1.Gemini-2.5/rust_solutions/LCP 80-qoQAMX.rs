impl Solution {
    pub fn longest_common_subsequence(text1: String, text2: String) -> i32 {
        let n = text1.len();
        let m = text2.len();

        let s1_chars: Vec<char> = text1.chars().collect();
        let s2_chars: Vec<char> = text2.chars().collect();

        let mut dp = vec![vec![0; m + 1]; n + 1];

        for i in 1..=n {
            for j in 1..=m {
                if s1_chars[i - 1] == s2_chars[j - 1] {
                    dp[i][j] = 1 + dp[i - 1][j - 1];
                } else {
                    dp[i][j] = dp[i - 1][j].max(dp[i][j - 1]);
                }
            }
        }

        dp[n][m]
    }
}