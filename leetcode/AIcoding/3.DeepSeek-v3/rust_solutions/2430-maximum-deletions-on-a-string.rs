impl Solution {
    pub fn delete_string(s: String) -> i32 {
        let n = s.len();
        let s = s.as_bytes();
        let mut dp = vec![1; n + 1];
        let mut lcs = vec![vec![0; n + 1]; n + 1];

        for i in (0..n).rev() {
            for j in (i + 1..n).rev() {
                if s[i] == s[j] {
                    lcs[i][j] = lcs[i + 1][j + 1] + 1;
                }
                if lcs[i][j] >= j - i {
                    dp[i] = dp[i].max(dp[j] + 1);
                }
            }
        }

        dp[0]
    }
}