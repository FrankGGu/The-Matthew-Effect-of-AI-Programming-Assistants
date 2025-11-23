use std::collections::HashMap;

impl Solution {
    pub fn count_words(words1: Vec<String>, words2: Vec<String>) -> i32 {
        let mut count1 = HashMap::new();
        let mut count2 = HashMap::new();

        for word in words1 {
            *count1.entry(word).or_insert(0) += 1;
        }

        for word in words2 {
            *count2.entry(word).or_insert(0) += 1;
        }

        let mut result = 0;
        for (word, cnt) in count1 {
            if cnt == 1 && count2.get(&word).map_or(false, |&c| c == 1) {
                result += 1;
            }
        }

        result
    }
}