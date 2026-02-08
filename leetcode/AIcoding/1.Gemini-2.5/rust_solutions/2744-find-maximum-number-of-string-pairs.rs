use std::collections::HashSet;

impl Solution {
    pub fn maximum_number_of_string_pairs(words: Vec<String>) -> i32 {
        let mut count = 0;
        let mut seen_reversed_words: HashSet<String> = HashSet::new();

        for word in words {
            let reversed_word: String = word.chars().rev().collect();

            if seen_reversed_words.contains(&word) {
                count += 1;
                seen_reversed_words.remove(&word);
            } else {
                seen_reversed_words.insert(reversed_word);
            }
        }

        count
    }
}