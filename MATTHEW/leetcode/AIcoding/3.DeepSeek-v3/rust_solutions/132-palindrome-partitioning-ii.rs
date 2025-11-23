impl Solution {
    pub fn min_cut(s: String) -> i32 {
        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();
        let mut is_palindrome = vec![vec![false; n]; n];
        let mut dp = vec![0; n];

        for i in 0..n {
            dp[i] = i as i32;
            for j in 0..=i {
                if s_chars[i] == s_chars[j] && (i - j <= 2 || is_palindrome[j + 1][i - 1]) {
                    is_palindrome[j][i] = true;
                    if j == 0 {
                        dp[i] = 0;
                    } else {
                        dp[i] = dp[i].min(dp[j - 1] + 1);
                    }
                }
            }
        }

        dp[n - 1]
    }
}