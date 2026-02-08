impl Solution {
    pub fn is_interleave(s1: String, s2: String, s3: String) -> bool {
        let s1 = s1.as_bytes();
        let s2 = s2.as_bytes();
        let s3 = s3.as_bytes();
        let n = s1.len();
        let m = s2.len();
        if n + m != s3.len() {
            return false;
        }
        let mut dp = vec![vec![false; m + 1]; n + 1];
        dp[0][0] = true;
        for i in 1..=n {
            dp[i][0] = dp[i - 1][0] && s1[i - 1] == s3[i - 1];
        }
        for j in 1..=m {
            dp[0][j] = dp[0][j - 1] && s2[j - 1] == s3[j - 1];
        }
        for i in 1..=n {
            for j in 1..=m {
                dp[i][j] = (dp[i - 1][j] && s1[i - 1] == s3[i + j - 1]) ||
                           (dp[i][j - 1] && s2[j - 1] == s3[i + j - 1]);
            }
        }
        dp[n][m]
    }
}