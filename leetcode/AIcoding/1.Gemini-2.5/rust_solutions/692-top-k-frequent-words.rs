use std::collections::HashMap;

impl Solution {
    pub fn top_k_frequent(words: Vec<String>, k: i32) -> Vec<String> {
        let mut counts: HashMap<String, i32> = HashMap::new();
        for word in words {
            *counts.entry(word).or_insert(0) += 1;
        }

        let mut frequent_words: Vec<(String, i32)> = counts.into_iter().collect();

        frequent_words.sort_unstable_by(|a, b| {
            if a.1 != b.1 {
                b.1.cmp(&a.1) // Sort by frequency descending
            } else {
                a.0.cmp(&b.0) // Sort by word ascending if frequencies are equal
            }
        });

        frequent_words
            .into_iter()
            .take(k as usize)
            .map(|(word, _)| word)
            .collect()
    }
}