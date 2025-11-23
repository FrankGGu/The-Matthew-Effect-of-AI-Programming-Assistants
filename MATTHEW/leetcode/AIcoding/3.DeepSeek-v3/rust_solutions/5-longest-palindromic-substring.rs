impl Solution {
    pub fn longest_palindrome(s: String) -> String {
        let n = s.len();
        if n == 0 {
            return String::new();
        }
        let s_bytes = s.as_bytes();
        let mut start = 0;
        let mut max_len = 1;
        let mut dp = vec![vec![false; n]; n];

        for i in 0..n {
            dp[i][i] = true;
        }

        for i in 0..n - 1 {
            if s_bytes[i] == s_bytes[i + 1] {
                dp[i][i + 1] = true;
                start = i;
                max_len = 2;
            }
        }

        for len in 3..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                if s_bytes[i] == s_bytes[j] && dp[i + 1][j - 1] {
                    dp[i][j] = true;
                    if len > max_len {
                        start = i;
                        max_len = len;
                    }
                }
            }
        }

        String::from_utf8(s_bytes[start..start + max_len].to_vec()).unwrap()
    }
}