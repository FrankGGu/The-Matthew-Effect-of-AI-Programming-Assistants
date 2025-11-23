use std::collections::HashMap;

pub fn find_num_of_valid_words(words: Vec<String>, puzzles: Vec<String>) -> Vec<i32> {
    let mut word_mask_count = HashMap::new();

    for word in words {
        let mut mask = 0;
        for byte in word.bytes() {
            mask |= 1 << (byte - b'a');
        }
        *word_mask_count.entry(mask).or_insert(0) += 1;
    }

    let mut result = Vec::new();

    for puzzle in puzzles {
        let first_char_mask = 1 << (puzzle.as_bytes()[0] - b'a');
        let mut count = 0;

        for mask in word_mask_count.keys() {
            if mask & first_char_mask != 0 {
                let mut valid = true;
                for byte in puzzle.bytes().skip(1) {
                    if mask & (1 << (byte - b'a')) == 0 {
                        valid = false;
                        break;
                    }
                }
                if valid {
                    count += word_mask_count[mask];
                }
            }
        }

        result.push(count);
    }

    result
}