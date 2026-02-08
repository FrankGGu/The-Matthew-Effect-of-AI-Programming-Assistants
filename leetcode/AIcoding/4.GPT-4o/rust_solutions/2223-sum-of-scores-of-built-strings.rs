impl Solution {
    pub fn sum_of_scores(s: String) -> i32 {
        let n = s.len();
        let mut total_score = 0;
        let mut dp = vec![0; n + 1];

        for i in (0..n).rev() {
            for j in (i + 1..=n).rev() {
                if s[i..j].chars().all(|c| c == s[i..j].chars().next().unwrap()) {
                    dp[i] = dp[j] + (j - i) as i32;
                    total_score += dp[i];
                }
            }
        }

        total_score
    }
}