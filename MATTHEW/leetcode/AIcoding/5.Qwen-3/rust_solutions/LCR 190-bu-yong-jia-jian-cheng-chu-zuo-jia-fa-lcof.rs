impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn find_secret_word(mut possible_words: Vec<String>, mut master: Master) {
        let mut count = 0;
        while count < 10 {
            let guess = get_guess(&possible_words);
            let match_count = master.guess(guess.clone());
            if match_count == 0 {
                possible_words.retain(|word| {
                    word.chars().zip(guess.chars()).filter(|&(a, b)| a == b).count() == 0
                });
            } else {
                possible_words.retain(|word| {
                    word.chars().zip(guess.chars()).filter(|&(a, b)| a == b).count() == match_count
                });
            }
            count += 1;
        }
    }

    fn get_guess(words: &[String]) -> String {
        let mut freq = HashMap::new();
        for word in words {
            for (i, c) in word.chars().enumerate() {
                *freq.entry((i, c)).or_insert(0) += 1;
            }
        }
        words.iter()
            .max_by(|a, b| {
                let score_a = a.chars().enumerate().map(|(i, c)| freq.get(&(i, c)).copied().unwrap_or(0)).sum::<usize>();
                let score_b = b.chars().enumerate().map(|(i, c)| freq.get(&(i, c)).copied().unwrap_or(0)).sum::<usize>();
                score_a.cmp(&score_b)
            })
            .cloned()
            .unwrap()
    }
}

trait Master {
    fn guess(&mut self, word: String) -> i32;
}
}