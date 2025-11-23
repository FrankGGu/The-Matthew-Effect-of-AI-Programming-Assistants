impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_product(words: Vec<String>) -> i32 {
        let mut masks = vec![];
        for word in &words {
            let mut mask = 0;
            for c in word.chars() {
                mask |= 1 << (c as u8 - b'a' as u8);
            }
            masks.push(mask);
        }

        let mut max_prod = 0;
        for i in 0..words.len() {
            for j in i+1..words.len() {
                if masks[i] & masks[j] == 0 {
                    max_prod = max_prod.max((words[i].len() * words[j].len()) as i32);
                }
            }
        }

        max_prod
    }
}
}