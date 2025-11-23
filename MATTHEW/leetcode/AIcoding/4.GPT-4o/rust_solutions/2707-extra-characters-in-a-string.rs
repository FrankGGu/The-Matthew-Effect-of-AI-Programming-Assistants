impl Solution {
    pub fn min_extra_char(s: String, dictionary: Vec<String>) -> i32 {
        let mut dp = vec![0; s.len() + 1];
        let dict_set: std::collections::HashSet<&str> = dictionary.iter().map(|s| s.as_str()).collect();

        for i in 1..=s.len() {
            dp[i] = dp[i - 1] + 1;
            for j in 0..i {
                if dict_set.contains(&s[j..i]) {
                    dp[i] = dp[i].min(dp[j]);
                }
            }
        }

        dp[s.len()]
    }
}