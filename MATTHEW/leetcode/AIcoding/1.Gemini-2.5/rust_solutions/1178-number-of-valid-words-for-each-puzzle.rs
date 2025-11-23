use std::collections::HashMap;

impl Solution {
    pub fn find_num_of_valid_words(words: Vec<String>, puzzles: Vec<String>) -> Vec<i32> {
        let mut word_masks_counts: HashMap<u32, i32> = HashMap::new();
        for word in words {
            let mut word_mask = 0;
            for c in word.chars() {
                word_mask |= 1 << (c as u8 - b'a');
            }
            *word_masks_counts.entry(word_mask).or_insert(0) += 1;
        }

        let mut results: Vec<i32> = Vec::with_capacity(puzzles.len());

        for puzzle in puzzles {
            let mut puzzle_mask = 0;
            let first_char_bit: u32 = 1 << (puzzle.chars().next().unwrap() as u8 - b'a');

            for c in puzzle.chars() {
                puzzle_mask |= 1 << (c as u8 - b'a');
            }

            let mut current_puzzle_valid_words_count = 0;

            let mut submask = puzzle_mask;
            loop {
                if (submask & first_char_bit) != 0 {
                    if let Some(&count) = word_masks_counts.get(&submask) {
                        current_puzzle_valid_words_count += count;
                    }
                }

                if submask == 0 {
                    break;
                }
                submask = (submask - 1) & puzzle_mask;
            }
            results.push(current_puzzle_valid_words_count);
        }

        results
    }
}