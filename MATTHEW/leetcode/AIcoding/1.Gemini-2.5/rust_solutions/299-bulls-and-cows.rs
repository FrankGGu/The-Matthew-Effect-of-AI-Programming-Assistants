impl Solution {
    pub fn get_hint(secret: String, guess: String) -> String {
        let mut bulls = 0;
        let mut cows = 0;

        let mut secret_counts = [0; 10];
        let mut guess_counts = [0; 10];

        let secret_bytes = secret.as_bytes();
        let guess_bytes = guess.as_bytes();

        for i in 0..secret.len() {
            if secret_bytes[i] == guess_bytes[i] {
                bulls += 1;
            } else {
                secret_counts[(secret_bytes[i] - b'0') as usize] += 1;
                guess_counts[(guess_bytes[i] - b'0') as usize] += 1;
            }
        }

        for i in 0..10 {
            cows += secret_counts[i].min(guess_counts[i]);
        }

        format!("{}A{}B", bulls, cows)
    }
}