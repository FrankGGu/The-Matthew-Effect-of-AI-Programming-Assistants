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

        for j in 1..=n2 {
            dp[0][j] = dp[0][j - 1] && s2_chars[j - 1] == s3_chars[j - 1];
        }

        for i in 1..=n1 {
            dp[i][0] = dp[i - 1][0] && s1_chars[i - 1] == s3_chars[i - 1];
        }

        for i in 1..=n1 {
            for j in 1..=n2 {
                let char_s3_idx = i + j - 1;

                let mut from_s1 = false;
                if dp[i - 1][j] && s1_chars[i - 1] == s3_chars[char_s3_idx] {
                    from_s1 = true;
                }

                let mut from_s2 = false;
                if dp[i][j - 1] && s2_chars[j - 1] == s3_chars[char_s3_idx] {
                    from_s2 = true;
                }

                dp[i][j] = from_s1 || from_s2;
            }
        }

        dp[n1][n2]
    }
}