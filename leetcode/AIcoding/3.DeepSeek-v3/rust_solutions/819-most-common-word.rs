use std::collections::HashMap;

impl Solution {
    pub fn most_common_word(paragraph: String, banned: Vec<String>) -> String {
        let banned: std::collections::HashSet<_> = banned.into_iter().collect();
        let mut freq = HashMap::new();
        let mut max_freq = 0;
        let mut result = String::new();

        for word in paragraph.split(|c: char| !c.is_alphabetic()) {
            let word = word.to_lowercase();
            if word.is_empty() || banned.contains(&word) {
                continue;
            }
            let count = freq.entry(word.clone()).or_insert(0);
            *count += 1;
            if *count > max_freq {
                max_freq = *count;
                result = word;
            }
        }

        result
    }
}