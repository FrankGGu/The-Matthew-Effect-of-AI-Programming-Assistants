use std::collections::HashMap;

impl Solution {
    pub fn most_common_word(paragraph: String, banned: Vec<String>) -> String {
        let banned_set: std::collections::HashSet<String> = banned.into_iter().collect();
        let mut word_counts: HashMap<String, i32> = HashMap::new();

        let mut word = String::new();
        for c in paragraph.chars() {
            if c.is_alphabetic() {
                word.push(c.to_ascii_lowercase());
            } else {
                if !word.is_empty() {
                    if !banned_set.contains(&word) {
                        *word_counts.entry(word.clone()).or_insert(0) += 1;
                    }
                    word.clear();
                }
            }
        }

        if !word.is_empty() {
            if !banned_set.contains(&word) {
                *word_counts.entry(word.clone()).or_insert(0) += 1;
            }
        }

        let mut most_common = String::new();
        let mut max_count = 0;

        for (w, c) in word_counts.iter() {
            if *c > max_count {
                max_count = *c;
                most_common = w.clone();
            }
        }

        most_common
    }
}