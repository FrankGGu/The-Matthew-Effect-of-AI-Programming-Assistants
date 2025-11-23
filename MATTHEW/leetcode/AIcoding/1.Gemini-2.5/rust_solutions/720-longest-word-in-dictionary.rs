use std::collections::HashSet;

impl Solution {
    pub fn longest_word(mut words: Vec<String>) -> String {
        let mut word_set: HashSet<String> = HashSet::new();
        for word in &words {
            word_set.insert(word.clone());
        }

        words.sort(); // Sort lexicographically for tie-breaking and consistent processing

        let mut longest_word = String::new();

        for word in words {
            let mut is_buildable = true;

            // A word is buildable if all its prefixes (excluding itself) are in the dictionary.
            // Words of length 1 are considered buildable by definition.
            if word.len() > 1 {
                for i in 1..word.len() {
                    let prefix = &word[0..i];
                    if !word_set.contains(prefix) {
                        is_buildable = false;
                        break;
                    }
                }
            }

            if is_buildable {
                // If the current word is longer than the current longest_word, update it.
                // If they are of the same length, since `words` is sorted lexicographically,
                // the current `word` would be lexicographically greater than or equal to
                // the existing `longest_word` (if it also has the same length).
                // Thus, we only update if `word` is strictly longer.
                if word.len() > longest_word.len() {
                    longest_word = word;
                }
            }
        }

        longest_word
    }
}