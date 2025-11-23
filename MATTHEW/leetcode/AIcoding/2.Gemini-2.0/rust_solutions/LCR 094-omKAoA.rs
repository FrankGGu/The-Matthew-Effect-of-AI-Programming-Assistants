impl Solution {
    pub fn min_cut(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();

        let mut is_palindrome = vec![vec![false; n]; n];
        for i in (0..n).rev() {
            for j in i..n {
                if s_bytes[i] == s_bytes[j] && (j - i <= 2 || is_palindrome[i + 1][j - 1]) {
                    is_palindrome[i][j] = true;
                }
            }
        }

        let mut dp = vec![0; n];
        for i in 0..n {
            if is_palindrome[0][i] {
                dp[i] = 0;
            } else {
                dp[i] = i as i32;
                for j in 0..i {
                    if is_palindrome[j + 1][i] {
                        dp[i] = dp[i].min(dp[j] + 1);
                    }
                }
            }
        }

        dp[n - 1]
    }
}