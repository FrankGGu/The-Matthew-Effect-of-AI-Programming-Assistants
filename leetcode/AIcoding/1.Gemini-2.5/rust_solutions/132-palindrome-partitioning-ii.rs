impl Solution {
    pub fn min_cut(s: String) -> i32 {
        let n = s.len();
        if n == 0 {
            return 0;
        }

        let s_bytes = s.as_bytes();

        let mut is_palindrome = vec![vec![false; n]; n];

        for i in 0..n {
            is_palindrome[i][i] = true;
        }

        for i in 0..(n - 1) {
            if s_bytes[i] == s_bytes[i + 1] {
                is_palindrome[i][i + 1] = true;
            }
        }

        for len in 3..=n {
            for i in 0..=(n - len) {
                let j = i + len - 1;
                if s_bytes[i] == s_bytes[j] && is_palindrome[i + 1][j - 1] {
                    is_palindrome[i][j] = true;
                }
            }
        }

        let mut dp = vec![0; n + 1];
        dp[0] = -1; 

        for i in 1..=n {
            dp[i] = i as i32 - 1; 

            for j in 0..i {
                if is_palindrome[j][i - 1] {
                    dp[i] = dp[i].min(dp[j] + 1);
                }
            }
        }

        dp[n]
    }
}