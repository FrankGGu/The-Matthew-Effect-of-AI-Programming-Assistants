impl Solution {
    pub fn delete_string(s: String) -> i32 {
        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();
        let mut dp = vec![1; n];

        for i in (0..n - 1).rev() {
            for j in 1..=(n - i) / 2 {
                if s_chars[i..i + j] == s_chars[i + j..i + 2 * j] {
                    dp[i] = dp[i].max(dp[i + j] + 1);
                }
            }
        }

        dp[0]
    }
}