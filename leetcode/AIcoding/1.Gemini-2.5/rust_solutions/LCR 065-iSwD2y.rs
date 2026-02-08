use std::collections::HashSet;

impl Solution {
    pub fn minimum_length_encoding(words: Vec<String>) -> i32 {
        let mut unique_words: HashSet<String> = words.into_iter().collect();

        // Iterate through the original list of words.
        // For each word, generate all its proper suffixes (suffixes shorter than the word itself).
        // If a suffix exists in our `unique_words` set, it means that suffix is covered by the current word,
        // so we can remove it from the set.
        for word in &words {
            for i in 1..word.len() {
                let suffix = &word[i..];
                unique_words.remove(suffix);
            }
        }

        // The remaining words in `unique_words` are those that are not suffixes of any other word
        // in the original input. These are the words that must be included in our compressed encoding.
        // For each such word, we add its length plus one (for the '#' character) to the total length.
        let mut total_length = 0;
        for word in unique_words.iter() {
            total_length += word.len() as i32 + 1;
        }

        total_length
    }
}