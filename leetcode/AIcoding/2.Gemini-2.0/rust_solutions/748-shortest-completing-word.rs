use std::collections::HashMap;

impl Solution {
    pub fn shortest_completing_word(license_plate: String, words: Vec<String>) -> String {
        let mut license_map: HashMap<char, i32> = HashMap::new();
        for c in license_plate.chars() {
            if c.is_alphabetic() {
                let lower_c = c.to_lowercase().next().unwrap();
                *license_map.entry(lower_c).or_insert(0) += 1;
            }
        }

        let mut shortest_word = String::new();
        let mut min_len = i32::max_value();

        for word in words {
            let mut word_map: HashMap<char, i32> = HashMap::new();
            for c in word.chars() {
                *word_map.entry(c).or_insert(0) += 1;
            }

            let mut complete = true;
            for (c, count) in &license_map {
                if !word_map.contains_key(c) || word_map[c] < *count {
                    complete = false;
                    break;
                }
            }

            if complete {
                if word.len() < min_len as usize {
                    min_len = word.len() as i32;
                    shortest_word = word;
                }
            }
        }

        shortest_word
    }
}