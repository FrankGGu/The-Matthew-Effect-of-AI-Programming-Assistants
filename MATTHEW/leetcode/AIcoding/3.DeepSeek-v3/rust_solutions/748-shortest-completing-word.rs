use std::collections::HashMap;

impl Solution {
    pub fn shortest_completing_word(license_plate: String, words: Vec<String>) -> String {
        let mut target = HashMap::new();
        for c in license_plate.chars() {
            if c.is_alphabetic() {
                let lower_c = c.to_ascii_lowercase();
                *target.entry(lower_c).or_insert(0) += 1;
            }
        }

        let mut shortest_word = String::new();
        for word in words {
            let mut freq = HashMap::new();
            for c in word.chars() {
                *freq.entry(c).or_insert(0) += 1;
            }

            let mut is_completing = true;
            for (k, v) in target.iter() {
                if freq.get(k).unwrap_or(&0) < v {
                    is_completing = false;
                    break;
                }
            }

            if is_completing && (shortest_word.is_empty() || word.len() < shortest_word.len()) {
                shortest_word = word.clone();
            }
        }

        shortest_word
    }
}