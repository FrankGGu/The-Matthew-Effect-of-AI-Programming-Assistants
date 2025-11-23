use std::collections::VecDeque;

impl Solution {
    pub fn num_matching_subsequences(s: String, words: Vec<String>) -> i32 {
        let mut count = 0;
        // `waiting_words[char_code]` stores a list of `(word_slice, current_index_in_word)` tuples.
        // `word_slice` is a reference to the original word string, and `current_index_in_word`
        // is the index of the character we are currently looking for in that word.
        // The array has 26 elements, one for each lowercase English letter ('a' through 'z').
        let mut waiting_words: [VecDeque<(&str, usize)>; 26] = std::array::from_fn(|_| VecDeque::new());

        // Initialize the `waiting_words` structure by placing each word
        // into the `VecDeque` corresponding to its first character.
        for word_string in &words {
            let word_slice: &str = word_string.as_str();
            if word_slice.is_empty() {
                // An empty string is considered a subsequence of any string.
                count += 1;
                continue;
            }
            // Calculate the index for the first character of the word.
            let first_char_code = (word_slice.as_bytes()[0] - b'a') as usize;
            waiting_words[first_char_code].push_back((word_slice, 0));
        }

        // Iterate through each character of the string `s`.
        for s_char_byte in s.as_bytes() {
            let char_code = (s_char_byte - b'a') as usize;

            // Create a temporary `VecDeque` to hold words that are currently
            // waiting for the character `s_char_byte`. This is done to safely
            // drain elements from `waiting_words[char_code]` while potentially
            // pushing new elements into other `VecDeque`s within `waiting_words`.
            let mut words_to_process = VecDeque::new();
            std::mem::swap(&mut waiting_words[char_code], &mut words_to_process);

            // Process each word that was waiting for `s_char_byte`.
            for (word_slice, current_idx) in words_to_process {
                let next_idx = current_idx + 1;
                if next_idx == word_slice.len() {
                    // If `next_idx` equals the word's length, the entire word has been matched.
                    count += 1;
                } else {
                    // If the word is not fully matched, move it to the `VecDeque`
                    // corresponding to its next required character.
                    let next_char_code = (word_slice.as_bytes()[next_idx] - b'a') as usize;
                    waiting_words[next_char_code].push_back((word_slice, next_idx));
                }
            }
        }

        count
    }
}