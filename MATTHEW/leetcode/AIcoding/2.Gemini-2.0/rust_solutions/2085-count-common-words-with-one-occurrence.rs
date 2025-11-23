use std::collections::HashMap;

impl Solution {
    pub fn count_common_words(words1: Vec<String>, words2: Vec<String>) -> i32 {
        let mut count1: HashMap<String, i32> = HashMap::new();
        let mut count2: HashMap<String, i32> = HashMap::new();

        for word in &words1 {
            *count1.entry(word.clone()).or_insert(0) += 1;
        }

        for word in &words2 {
            *count2.entry(word.clone()).or_insert(0) += 1;
        }

        let mut result = 0;
        for (word, freq) in &count1 {
            if *freq == 1 && count2.contains_key(word) && count2[word] == 1 {
                result += 1;
            }
        }

        result
    }
}