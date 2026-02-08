impl Solution {
    pub fn longest_palindrome(word1: String, word2: String) -> i32 {
        let s: Vec<char> = word1.chars().chain(word2.chars()).collect();
        let n = s.len();
        let mut dp = vec![vec![0; n]; n];
        let mut res = 0;

        for i in (0..n).rev() {
            dp[i][i] = 1;
            for j in i + 1..n {
                if s[i] == s[j] {
                    dp[i][j] = dp[i + 1][j - 1] + 2;
                    if i < word1.len() && j >= word1.len() {
                        res = res.max(dp[i][j]);
                    }
                } else {
                    dp[i][j] = dp[i + 1][j].max(dp[i][j - 1]);
                }
            }
        }

        res
    }
}