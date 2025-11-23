impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn common_words(word1: Vec<String>, word2: Vec<String>) -> i32 {
        let mut count1 = HashMap::new();
        let mut count2 = HashMap::new();

        for word in &word1 {
            *count1.entry(word).or_insert(0) += 1;
        }

        for word in &word2 {
            *count2.entry(word).or_insert(0) += 1;
        }

        let mut result = 0;

        for (word, &cnt) in &count1 {
            if cnt == 1 && count2.get(word) == Some(&1) {
                result += 1;
            }
        }

        result
    }
}
}