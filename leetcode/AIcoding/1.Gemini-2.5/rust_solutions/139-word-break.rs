use std::collections::HashSet;

impl Solution {
    pub fn word_break(s: String, word_dict: Vec<String>) -> bool {
        let word_set: HashSet<String> = word_dict.into_iter().collect();
        let n = s.len();
        let mut dp = vec![false; n + 1];
        dp[0] = true;

        for i in 1..=n {
            for j in 0..i {
                if dp[j] {
                    let sub_str = &s[j..i];
                    if word_set.contains(sub_str) {
                        dp[i] = true;
                        break;
                    }
                }
            }
        }

        dp[n]
    }
}