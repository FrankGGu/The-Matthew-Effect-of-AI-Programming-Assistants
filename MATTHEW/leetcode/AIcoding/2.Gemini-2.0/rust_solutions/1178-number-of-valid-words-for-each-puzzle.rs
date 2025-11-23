use std::collections::HashSet;

impl Solution {
    pub fn find_num_of_valid_words(words: Vec<String>, puzzles: Vec<String>) -> Vec<i32> {
        let mut word_masks: Vec<i32> = Vec::new();
        for word in &words {
            let mut mask = 0;
            for c in word.chars() {
                mask |= 1 << (c as u8 - b'a');
            }
            word_masks.push(mask);
        }

        let mut result: Vec<i32> = Vec::new();
        for puzzle in &puzzles {
            let first_char_mask = 1 << (puzzle.chars().next().unwrap() as u8 - b'a');
            let mut count = 0;
            for &word_mask in &word_masks {
                if (word_mask & first_char_mask) != 0 {
                    let mut puzzle_mask = 0;
                    for c in puzzle.chars() {
                        puzzle_mask |= 1 << (c as u8 - b'a');
                    }
                    if (word_mask & puzzle_mask) == word_mask {
                        count += 1;
                    }
                }
            }
            result.push(count);
        }

        result
    }
}