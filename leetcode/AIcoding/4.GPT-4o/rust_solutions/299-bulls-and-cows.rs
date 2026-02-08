impl Solution {
    pub fn get_hint(secret: String, guess: String) -> String {
        let mut count = vec![0; 10];
        let mut bulls = 0;
        let mut cows = 0;

        for (s, g) in secret.chars().zip(guess.chars()) {
            if s == g {
                bulls += 1;
            } else {
                count[s.to_digit(10).unwrap() as usize] += 1;
                count[g.to_digit(10).unwrap() as usize] -= 1;
            }
        }

        for &c in &count {
            if c > 0 {
                cows += c;
            }
        }

        format!("{}A{}B", bulls, cows)
    }
}