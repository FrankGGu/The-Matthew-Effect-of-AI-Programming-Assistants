use std::collections::HashMap;

impl Solution {
    pub fn find_num_of_valid_words(words: Vec<String>, puzzles: Vec<String>) -> Vec<i32> {
        let mut freq = HashMap::new();
        for word in words {
            let mut mask = 0;
            for c in word.chars() {
                mask |= 1 << (c as u8 - b'a');
            }
            *freq.entry(mask).or_insert(0) += 1;
        }

        let mut res = Vec::with_capacity(puzzles.len());
        for puzzle in puzzles {
            let first_char_mask = 1 << (puzzle.chars().next().unwrap() as u8 - b'a');
            let mut mask = 0;
            for c in puzzle.chars() {
                mask |= 1 << (c as u8 - b'a');
            }
            let mut count = 0;
            let mut subset = mask;
            loop {
                if (subset & first_char_mask) != 0 {
                    count += freq.get(&subset).unwrap_or(&0);
                }
                if subset == 0 {
                    break;
                }
                subset = (subset - 1) & mask;
            }
            res.push(count);
        }
        res
    }
}