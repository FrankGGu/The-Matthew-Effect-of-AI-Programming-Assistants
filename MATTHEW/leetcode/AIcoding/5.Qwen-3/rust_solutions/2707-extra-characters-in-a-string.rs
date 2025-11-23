impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn min_extra_char_mutations(s: String, dictionary: Vec<String>) -> i32 {
        let n = s.len();
        let mut dp = vec![0; n + 1];

        let dict_set: HashSet<String> = dictionary.into_iter().collect();

        for i in 1..=n {
            dp[i] = dp[i - 1] + 1;

            for j in 1..=i {
                let substr = &s[(i - j)..i];
                if dict_set.contains(substr) {
                    dp[i] = dp[i].min(dp[i - j]);
                }
            }
        }

        dp[n]
    }
}
}