use std::collections::HashSet;

impl Solution {
    pub fn minimum_length_encoding(words: Vec<String>) -> i32 {
        let mut unique_words: HashSet<String> = words.into_iter().collect();

        // Iterate over a clone of the set to allow modification of the original set
        for word in unique_words.clone().iter() {
            // Generate all proper suffixes of the current word
            for i in 1..word.len() {
                let suffix = &word[i..];
                // If this suffix exists in our set, it means it's covered by the current word
                // (or another longer word that contains this suffix), so we remove it.
                unique_words.remove(suffix);
            }
        }

        let mut total_length = 0;
        // The remaining words in unique_words are those that are not suffixes of any other word.
        // These are the words that must be explicitly included in the encoding.
        for word in unique_words.iter() {
            // Each word contributes its length plus one for the '#' terminator.
            total_length += word.len() as i32 + 1;
        }

        total_length
    }
}