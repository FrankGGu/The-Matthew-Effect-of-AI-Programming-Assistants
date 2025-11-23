impl Solution {
    pub fn minimum_pushes(word1: String, word2: String) -> i32 {
        let n = word1.len();
        let m = word2.len();
        let mut dp = vec![vec![0; m + 1]; n + 1];

        for i in 0..=n {
            for j in 0..=m {
                if i == 0 || j == 0 {
                    dp[i][j] = i + j;
                } else if word1.chars().nth(i - 1) == word2.chars().nth(j - 1) {
                    dp[i][j] = dp[i - 1][j - 1];
                } else {
                    dp[i][j] = 1 + dp[i - 1][j].min(dp[i][j - 1]);
                }
            }
        }
        dp[n][m]
    }
}