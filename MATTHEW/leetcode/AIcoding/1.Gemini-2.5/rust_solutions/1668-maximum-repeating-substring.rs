impl Solution {
    pub fn max_repeating(sequence: String, word: String) -> i32 {
        let mut count = 0;
        let mut current_repeated_word = String::new();

        loop {
            current_repeated_word.push_str(&word);
            if sequence.contains(&current_repeated_word) {
                count += 1;
            } else {
                break;
            }
        }
        count
    }
}