impl Solution {
    pub fn find_all_concatenated_words_in_a_dict(words: Vec<String>) -> Vec<String> {
        let mut word_set = std::collections::HashSet::new();
        for word in &words {
            word_set.insert(word.clone());
        }

        let mut result = Vec::new();
        for word in &words {
            if Self::can_form(word, &word_set) {
                result.push(word.clone());
            }
        }
        result
    }

    fn can_form(word: &str, word_set: &std::collections::HashSet<String>) -> bool {
        if word.is_empty() {
            return false;
        }
        let n = word.len();
        let mut dp = vec![false; n + 1];
        dp[0] = true;

        for i in 1..=n {
            for j in 0..i {
                if dp[j] {
                    let sub = &word[j..i];
                    if word_set.contains(sub) && sub != word {
                        dp[i] = true;
                        break;
                    }
                }
            }
        }
        dp[n]
    }
}