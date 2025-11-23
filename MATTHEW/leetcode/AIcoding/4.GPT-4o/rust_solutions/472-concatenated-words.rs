use std::collections::HashSet;

pub struct Solution;

impl Solution {
    pub fn find_all_concatenated_words_in_a_dict(words: Vec<String>) -> Vec<String> {
        let word_set: HashSet<&String> = words.iter().collect();
        let mut result = Vec::new();

        for word in &words {
            if Self::can_form_word(word, &word_set) {
                result.push(word.clone());
            }
        }

        result
    }

    fn can_form_word(word: &String, word_set: &HashSet<&String>) -> bool {
        let n = word.len();
        let mut dp = vec![false; n + 1];
        dp[0] = true;

        for i in 1..=n {
            for j in 0..i {
                if dp[j] && word_set.contains(&word[j..i].to_string()) {
                    dp[i] = true;
                    break;
                }
            }
        }

        dp[n] && word_set.contains(word) == false
    }
}