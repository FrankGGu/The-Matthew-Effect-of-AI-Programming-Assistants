impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn is_valid_word_dict(words: Vec<String>, order: String) -> bool {
        let order_map: HashMap<char, usize> = order.chars().enumerate().map(|(i, c)| (c, i)).collect();

        for i in 0..words.len() - 1 {
            let word1 = &words[i];
            let word2 = &words[i + 1];

            for j in 0..word1.len().min(word2.len()) {
                let c1 = word1.chars().nth(j).unwrap();
                let c2 = word2.chars().nth(j).unwrap();

                if c1 != c2 {
                    if order_map.get(&c1).unwrap() > order_map.get(&c2).unwrap() {
                        return false;
                    }
                    break;
                }
            }
        }

        true
    }
}
}