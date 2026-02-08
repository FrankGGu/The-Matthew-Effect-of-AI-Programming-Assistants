impl Solution {
    pub fn longest_palindrome(s: String) -> String {
        let s = s.as_bytes();
        let n = s.len();
        if n == 0 {
            return String::new();
        }

        let mut start = 0;
        let mut max_len = 1;

        let mut dp = vec![vec![false; n]; n];

        for i in 0..n {
            dp[i][i] = true;
        }

        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                if s[i] == s[j] {
                    if len == 2 {
                        dp[i][j] = true;
                    } else {
                        dp[i][j] = dp[i + 1][j - 1];
                    }
                }

                if dp[i][j] && len > max_len {
                    max_len = len;
                    start = i;
                }
            }
        }

        String::from_utf8_lossy(&s[start..start + max_len]).to_string()
    }
}