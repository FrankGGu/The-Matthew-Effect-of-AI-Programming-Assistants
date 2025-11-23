impl Solution {
    pub fn is_interleave(s1: String, s2: String, s3: String) -> bool {
        let (m, n, l) = (s1.len(), s2.len(), s3.len());
        if m + n != l {
            return false;
        }

        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();
        let s3_bytes = s3.as_bytes();

        let mut dp = vec![vec![false; n + 1]; m + 1];
        dp[0][0] = true;

        for i in 0..=m {
            for j in 0..=n {
                if i > 0 && dp[i - 1][j] && s1_bytes[i - 1] == s3_bytes[i + j - 1] {
                    dp[i][j] = true;
                }
                if j > 0 && dp[i][j - 1] && s2_bytes[j - 1] == s3_bytes[i + j - 1] {
                    dp[i][j] = dp[i][j] || true;
                }
            }
        }

        dp[m][n]
    }
}