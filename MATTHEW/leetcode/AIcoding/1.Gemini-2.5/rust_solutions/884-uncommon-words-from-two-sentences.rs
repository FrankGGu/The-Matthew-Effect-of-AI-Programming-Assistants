use std::collections::HashMap;

impl Solution {
    pub fn uncommon_from_sentences(s1: String, s2: String) -> Vec<String> {
        let mut word_counts: HashMap<String, i32> = HashMap::new();

        for word in s1.split_whitespace() {
            *word_counts.entry(word.to_string()).or_insert(0) += 1;
        }

        for word in s2.split_whitespace() {
            *word_counts.entry(word.to_string()).or_insert(0) += 1;
        }

        let mut uncommon_words: Vec<String> = Vec::new();
        for (word, count) in word_counts {
            if count == 1 {
                uncommon_words.push(word);
            }
        }

        uncommon_words
    }
}