use rand::seq::SliceRandom;
use rand::thread_rng;

impl Solution {
    pub fn find_secret_word(words: Vec<String>, master: &Master) {
        let mut candidates = words.clone();
        let mut rng = thread_rng();

        for _ in 0..10 {
            let guess_word = candidates.choose(&mut rng).unwrap().clone();
            let matches = master.guess(guess_word.clone());

            if matches == 6 {
                return;
            }

            candidates.retain(|word| {
                let mut count = 0;
                for (a, b) in word.chars().zip(guess_word.chars()) {
                    if a == b {
                        count += 1;
                    }
                }
                count == matches
            });
        }
    }
}