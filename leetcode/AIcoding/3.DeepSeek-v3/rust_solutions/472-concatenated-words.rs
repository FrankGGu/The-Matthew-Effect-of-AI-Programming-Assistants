use std::collections::HashSet;

impl Solution {
    pub fn find_all_concatenated_words_in_a_dict(words: Vec<String>) -> Vec<String> {
        let word_set: HashSet<_> = words.iter().map(|s| s.as_str()).collect();
        let mut res = Vec::new();

        for word in words {
            if word.is_empty() {
                continue;
            }
            let n = word.len();
            let mut dp = vec![false; n + 1];
            dp[0] = true;

            for i in 1..=n {
                for j in 0..i {
                    if dp[j] && word_set.contains(&word[j..i]) && (j != 0 || i != n) {
                        dp[i] = true;
                        break;
                    }
                }
            }

            if dp[n] {
                res.push(word);
            }
        }

        res
    }
}