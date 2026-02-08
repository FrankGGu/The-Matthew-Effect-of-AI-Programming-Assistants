use std::collections::HashSet;

impl Solution {
    pub fn min_extra_char(s: String, dictionary: Vec<String>) -> i32 {
        let dict: HashSet<String> = dictionary.into_iter().collect();
        let n = s.len();
        let mut dp = vec![0; n + 1];

        for i in 1..=n {
            dp[i] = dp[i - 1] + 1;
            for j in 0..i {
                if dict.contains(&s[j..i].to_string()) {
                    dp[i] = dp[i].min(dp[j]);
                }
            }
        }

        dp[n]
    }
}