use std::collections::HashSet;
use std::cmp::min;

impl Solution {
    pub fn min_extra_char(s: String, dictionary: Vec<String>) -> i32 {
        let n = s.len();
        let dict_set: HashSet<String> = dictionary.into_iter().collect();

        let mut dp = vec![0; n + 1];

        for i in 1..=n {
            dp[i] = dp[i-1] + 1; // Option 1: s[i-1] is an extra character

            for j in 0..i {
                let sub = &s[j..i]; // Substring s[j...i-1]
                if dict_set.contains(sub) {
                    dp[i] = min(dp[i], dp[j]); // Option 2: s[j...i-1] is a dictionary word
                }
            }
        }

        dp[n]
    }
}