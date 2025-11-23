impl Solution {
    pub fn get_hint(secret: String, guess: String) -> String {
        let secret_chars: Vec<char> = secret.chars().collect();
        let guess_chars: Vec<char> = guess.chars().collect();

        let mut bulls = 0;
        let mut cows = 0;

        let mut secret_counts = std::collections::HashMap::new();
        let mut guess_counts = std::collections::HashMap::new();

        for i in 0..secret_chars.len() {
            if secret_chars[i] == guess_chars[i] {
                bulls += 1;
            } else {
                *secret_counts.entry(secret_chars[i]).or_insert(0) += 1;
                *guess_counts.entry(guess_chars[i]).or_insert(0) += 1;
            }
        }

        for (digit, count) in guess_counts.iter() {
            if secret_counts.contains_key(digit) {
                cows += std::cmp::min(*count, *secret_counts.get(digit).unwrap());
            }
        }

        format!("{}A{}B", bulls, cows)
    }
}