use std::collections::HashSet;

impl Solution {
    pub fn count_words_obtained_after_adding_a_letter(start_words: Vec<String>, target_words: Vec<String>) -> i32 {
        // Helper function to convert a word into a bitmask.
        // Each bit in the u32 mask represents the presence of a unique letter ('a' through 'z').
        // For example, 'a' sets the 0th bit, 'b' sets the 1st bit, and so on.
        fn word_to_mask(word: &str) -> u32 {
            let mut mask = 0;
            for c in word.chars() {
                mask |= 1 << (c as u8 - b'a');
            }
            mask
        }

        // Store the bitmasks of all start_words in a HashSet for efficient O(1) average time lookups.
        let mut start_word_masks: HashSet<u32> = HashSet::new();
        for word in start_words {
            start_word_masks.insert(word_to_mask(&word));
        }

        let mut count = 0;
        // Iterate through each target_word to determine if it can be formed.
        for target_word in target_words {
            let target_mask = word_to_mask(&target_word);

            // A target_word can be obtained from a start_word by adding one letter
            // if, by removing exactly one letter from the target_word, we get a mask
            // that corresponds to an existing start_word.
            // This implies that the target_word must have exactly one more *distinct* letter
            // than the start_word.
            for i in 0..26 { // Iterate through all possible letters 'a' through 'z'
                // Check if the i-th letter (corresponding to bit i) is present in the target_word.
                if (target_mask >> i) & 1 == 1 {
                    // If it is, create a potential start_word_mask by "removing" this letter.
                    // This is done by XORing with (1 << i), which flips the i-th bit.
                    // Since we know the i-th bit was set, this operation unsets it.
                    let potential_start_mask = target_mask ^ (1 << i);

                    // Check if this potential_start_mask exists in our set of start_word_masks.
                    if start_word_masks.contains(&potential_start_mask) {
                        count += 1;
                        // Once we find one way to form the target_word, we can stop checking
                        // for this target_word and move to the next one.
                        break;
                    }
                }
            }
        }

        count
    }
}