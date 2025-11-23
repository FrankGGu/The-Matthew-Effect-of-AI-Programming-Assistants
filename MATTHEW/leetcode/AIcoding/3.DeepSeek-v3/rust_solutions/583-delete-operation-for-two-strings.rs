impl Solution {
    pub fn min_distance(word1: String, word2: String) -> i32 {
        let m = word1.len();
        let n = word2.len();
        let word1 = word1.as_bytes();
        let word2 = word2.as_bytes();
        let mut dp = vec![vec![0; n + 1]; m + 1];

        for i in 0..=m {
            for j in 0..=n {
                if i == 0 || j == 0 {
                    dp[i][j] = (i + j) as i32;
                } else if word1[i - 1] == word2[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1];
                } else {
                    dp[i][j] = 1 + dp[i - 1][j].min(dp[i][j - 1]);
                }
            }
        }

        dp[m][n]
    }
}