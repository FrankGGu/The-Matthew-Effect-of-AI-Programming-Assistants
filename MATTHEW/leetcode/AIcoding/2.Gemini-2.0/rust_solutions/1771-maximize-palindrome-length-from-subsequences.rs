impl Solution {
    pub fn max_palindrome(word1: String, word2: String) -> i32 {
        let s1 = word1.as_bytes();
        let s2 = word2.as_bytes();
        let n1 = s1.len();
        let n2 = s2.len();
        let s: Vec<u8> = s1.iter().chain(s2.iter()).cloned().collect();
        let n = n1 + n2;

        let mut dp = vec![vec![0; n]; n];
        for i in 0..n {
            dp[i][i] = 1;
        }

        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                if s[i] == s[j] {
                    dp[i][j] = dp[i + 1][j - 1] + 2;
                } else {
                    dp[i][j] = dp[i + 1][j].max(dp[i][j - 1]);
                }
            }
        }

        let mut ans = 0;
        for i in 0..n1 {
            for j in n1..n {
                if s[i] == s[j] {
                    ans = ans.max(dp[i + 1][j - 1] + 2);
                }
            }
        }

        ans
    }
}