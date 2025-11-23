impl Solution {
    pub fn is_interleave(s1: String, s2: String, s3: String) -> bool {
        let (len1, len2, len3) = (s1.len(), s2.len(), s3.len());
        if len1 + len2 != len3 {
            return false;
        }

        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();
        let s3_bytes = s3.as_bytes();

        let mut dp = vec![vec![false; len2 + 1]; len1 + 1];
        dp[0][0] = true;

        for i in 0..=len1 {
            for j in 0..=len2 {
                if i > 0 && s1_bytes[i - 1] == s3_bytes[i + j - 1] {
                    dp[i][j] = dp[i][j] || dp[i - 1][j];
                }
                if j > 0 && s2_bytes[j - 1] == s3_bytes[i + j - 1] {
                    dp[i][j] = dp[i][j] || dp[i][j - 1];
                }
            }
        }

        dp[len1][len2]
    }
}