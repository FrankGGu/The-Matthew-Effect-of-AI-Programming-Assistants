use std::collections::HashSet;

impl Solution {
    pub fn count_substrings(words: Vec<String>, substr: String) -> i32 {
        let mut count = 0;
        let substr_len = substr.len();
        let mut substr_set = HashSet::new();

        for word in words.iter() {
            if word.len() < substr_len {
                continue;
            }
            for i in 0..=word.len() - substr_len {
                if &word[i..i + substr_len] == substr {
                    substr_set.insert(word.clone());
                    break;
                }
            }
        }

        count = substr_set.len() as i32;
        count
    }
}