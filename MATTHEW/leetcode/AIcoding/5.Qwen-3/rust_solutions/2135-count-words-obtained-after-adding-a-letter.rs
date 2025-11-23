impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn count_words(words1: Vec<String>, words2: Vec<String>) -> i32 {
        let mut word_count = HashSet::new();
        let mut word_count2 = HashSet::new();
        let mut result = 0;

        for word in &words1 {
            word_count.insert(word);
        }

        for word in &words2 {
            word_count2.insert(word);
        }

        for word in &words1 {
            if word_count.contains(word) && word_count2.contains(word) {
                result += 1;
            }
        }

        result
    }
}
}