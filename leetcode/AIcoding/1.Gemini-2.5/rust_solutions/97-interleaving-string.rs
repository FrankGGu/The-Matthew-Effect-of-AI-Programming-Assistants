impl Solution {
    pub fn is_interleave(s1: String, s2: String, s3: String) -> bool {
        let n1 = s1.len();
        let n2 = s2.len();
        let n3 = s3.len();

        if n1 + n2 != n3 {
            return false;
        }

        let s1_chars: Vec<char> = s1.chars().collect();
        let s2_chars: Vec<char> = s2.chars().collect();
        let s3_chars: Vec<char> = s3.chars().collect();

        let mut dp = vec![vec![false; n2 + 1]; n1 + 1];

        dp[0][0] = true;

        for i in 0..=n1 {
            for j in 0..=n2 {
                if i == 0 && j == 0 {
                    continue;
                }

                // If s3[i+j-1] matches s1[i-1] and dp[i-1][j] is true
                if i > 0 && s1_chars[i - 1] == s3_chars[i + j - 1] {
                    dp[i][j] = dp[i][j] || dp[i - 1][j];
                }

                // If s3[i+j-1] matches s2[j-1] and dp[i][j-1] is true
                if j > 0 && s2_chars[j - 1] == s3_chars[i + j - 1] {
                    dp[i][j] = dp[i][j] || dp[i][j - 1];
                }
            }
        }

        dp[n1][n2]
    }
}