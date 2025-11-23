use std::collections::HashMap;

impl Solution {
    pub fn count_words(words1: Vec<String>, words2: Vec<String>) -> i32 {
        let mut counts1: HashMap<String, i32> = HashMap::new();
        let mut counts2: HashMap<String, i32> = HashMap::new();

        for word in words1 {
            *counts1.entry(word).or_insert(0) += 1;
        }

        for word in words2 {
            *counts2.entry(word).or_insert(0) += 1;
        }

        let mut common_one_occurrence_count = 0;

        for (word, &count1) in &counts1 {
            if count1 == 1 {
                if let Some(&count2) = counts2.get(word) {
                    if count2 == 1 {
                        common_one_occurrence_count += 1;
                    }
                }
            }
        }

        common_one_occurrence_count
    }
}