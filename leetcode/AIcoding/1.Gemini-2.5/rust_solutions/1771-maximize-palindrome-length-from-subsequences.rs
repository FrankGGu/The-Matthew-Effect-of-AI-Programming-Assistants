impl Solution {
    pub fn longest_palindrome(word1: String, word2: String) -> i32 {
        let n1 = word1.len();
        let n2 = word2.len();
        let s = word1 + &word2;
        let s_chars: Vec<char> = s.chars().collect();
        let n = s_chars.len();

        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = 1;
        }

        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                if s_chars[i] == s_chars[j] {
                    dp[i][j] = 2 + dp[i + 1][j - 1];
                } else {
                    dp[i][j] = dp[i + 1][j].max(dp[i][j - 1]);
                }
            }
        }

        let mut max_len = 0;

        for i in 0..n1 {
            for j in n1..n {
                if s_chars[i] == s_chars[j] {
                    max_len = max_len.max(2 + dp[i + 1][j - 1]);
                }
            }
        }

        max_len
    }
}