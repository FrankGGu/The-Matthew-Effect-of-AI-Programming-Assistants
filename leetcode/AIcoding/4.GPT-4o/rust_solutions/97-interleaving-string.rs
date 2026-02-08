impl Solution {
    pub fn is_interleave(s1: String, s2: String, s3: String) -> bool {
        let m = s1.len();
        let n = s2.len();
        if m + n != s3.len() {
            return false;
        }

        let mut dp = vec![vec![false; n + 1]; m + 1];
        dp[0][0] = true;

        for i in 1..=m {
            dp[i][0] = dp[i - 1][0] && s1.as_bytes()[i - 1] == s3.as_bytes()[i - 1];
        }

        for j in 1..=n {
            dp[0][j] = dp[0][j - 1] && s2.as_bytes()[j - 1] == s3.as_bytes()[j - 1];
        }

        for i in 1..=m {
            for j in 1..=n {
                dp[i][j] = (dp[i - 1][j] && s1.as_bytes()[i - 1] == s3.as_bytes()[i + j - 1]) ||
                           (dp[i][j - 1] && s2.as_bytes()[j - 1] == s3.as_bytes()[i + j - 1]);
            }
        }

        dp[m][n]
    }
}