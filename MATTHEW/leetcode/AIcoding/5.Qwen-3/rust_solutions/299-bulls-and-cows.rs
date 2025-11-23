impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn get_hint(secret: String, guess: String) -> String {
        let mut bulls = 0;
        let mut secret_freq = HashMap::new();
        let mut guess_freq = HashMap::new();

        for (s, g) in secret.chars().zip(guess.chars()) {
            if s == g {
                bulls += 1;
            } else {
                *secret_freq.entry(s).or_insert(0) += 1;
                *guess_freq.entry(g).or_insert(0) += 1;
            }
        }

        let mut cows = 0;
        for (c, count) in &secret_freq {
            if let Some(g_count) = guess_freq.get(c) {
                cows += std::cmp::min(*count, *g_count);
            }
        }

        format!("{}A{}B", bulls, cows)
    }
}
}