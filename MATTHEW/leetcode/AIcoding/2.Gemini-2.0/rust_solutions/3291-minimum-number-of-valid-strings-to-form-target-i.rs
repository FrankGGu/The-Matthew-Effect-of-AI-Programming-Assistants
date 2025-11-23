impl Solution {
    pub fn min_number_of_valid_substrings(word: String, patterns: Vec<String>) -> i32 {
        let mut dp = vec![i32::MAX; word.len() + 1];
        dp[0] = 0;

        for i in 0..word.len() {
            if dp[i] == i32::MAX {
                continue;
            }

            dp[i + 1] = dp[i + 1].min(dp[i] + 1);

            for pattern in &patterns {
                if i + pattern.len() <= word.len() && word[i..].starts_with(pattern) {
                    dp[i + pattern.len()] = dp[i + pattern.len()].min(dp[i]);
                }
            }
        }

        if dp[word.len()] == i32::MAX {
            -1
        } else {
            dp[word.len()]
        }
    }
}