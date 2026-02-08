use std::collections::HashMap;

impl Solution {
    pub fn get_hint(secret: String, guess: String) -> String {
        let secret_bytes = secret.as_bytes();
        let guess_bytes = guess.as_bytes();
        let mut bulls = 0;
        let mut cows = 0;
        let mut secret_counts = HashMap::new();
        let mut guess_counts = HashMap::new();

        for i in 0..secret_bytes.len() {
            if secret_bytes[i] == guess_bytes[i] {
                bulls += 1;
            } else {
                *secret_counts.entry(secret_bytes[i]).or_insert(0) += 1;
                *guess_counts.entry(guess_bytes[i]).or_insert(0) += 1;
            }
        }

        for (k, &v) in secret_counts.iter() {
            cows += v.min(guess_counts.get(k).unwrap_or(&0));
        }

        format!("{}A{}B", bulls, cows)
    }
}