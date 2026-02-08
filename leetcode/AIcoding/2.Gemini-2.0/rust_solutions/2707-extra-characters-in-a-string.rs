impl Solution {
    pub fn min_extra_characters(s: String, dictionary: Vec<String>) -> i32 {
        let n = s.len();
        let mut dp = vec![0; n + 1];

        for i in 1..=n {
            dp[i] = dp[i - 1] + 1;
            for word in &dictionary {
                if i >= word.len() && s[i - word.len()..i] == *word {
                    dp[i] = dp[i].min(dp[i - word.len()]);
                }
            }
        }

        dp[n]
    }
}