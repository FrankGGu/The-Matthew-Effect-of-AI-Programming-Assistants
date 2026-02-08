use std::collections::HashSet;

impl Solution {
    pub fn word_count(start_words: Vec<String>, target_words: Vec<String>) -> i32 {
        let mut start_words_set: HashSet<i32> = HashSet::new();
        for word in start_words {
            let mut mask: i32 = 0;
            for c in word.chars() {
                mask |= 1 << (c as u8 - b'a');
            }
            start_words_set.insert(mask);
        }

        let mut count: i32 = 0;
        for word in target_words {
            let mut mask: i32 = 0;
            for c in word.chars() {
                mask |= 1 << (c as u8 - b'a');
            }
            for i in 0..26 {
                if (mask & (1 << i)) != 0 {
                    let new_mask = mask ^ (1 << i);
                    if start_words_set.contains(&new_mask) {
                        count += 1;
                        break;
                    }
                }
            }
        }

        count
    }
}