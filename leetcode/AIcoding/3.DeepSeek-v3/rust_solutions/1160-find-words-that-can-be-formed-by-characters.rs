use std::collections::HashMap;

impl Solution {
    pub fn count_characters(words: Vec<String>, chars: String) -> i32 {
        let mut char_counts = HashMap::new();
        for c in chars.chars() {
            *char_counts.entry(c).or_insert(0) += 1;
        }

        let mut total = 0;
        for word in words {
            let mut temp_counts = char_counts.clone();
            let mut valid = true;
            for c in word.chars() {
                let count = temp_counts.entry(c).or_insert(0);
                if *count == 0 {
                    valid = false;
                    break;
                }
                *count -= 1;
            }
            if valid {
                total += word.len() as i32;
            }
        }
        total
    }
}