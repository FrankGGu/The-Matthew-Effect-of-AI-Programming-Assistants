impl Solution {
    pub fn max_palindromes(s: String, k: usize) -> i32 {
        let n = s.len();
        let s = s.as_bytes();
        let mut dp = vec![0; n + 1];
        let mut pal = vec![vec![false; n]; n];

        for len in 1..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                if s[i] == s[j] && (len <= 2 || pal[i + 1][j - 1]) {
                    pal[i][j] = true;
                }
            }
        }

        for i in 0..n {
            dp[i + 1] = dp[i];
            for j in 0..=i {
                if pal[j][i] && i - j + 1 >= k {
                    dp[i + 1] = dp[i + 1].max(dp[j] + 1);
                }
            }
        }

        dp[n]
    }
}