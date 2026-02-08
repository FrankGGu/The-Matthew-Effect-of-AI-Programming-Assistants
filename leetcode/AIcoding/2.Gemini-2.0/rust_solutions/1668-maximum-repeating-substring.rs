impl Solution {
    pub fn max_repeating(sequence: String, word: String) -> i32 {
        let mut count = 0;
        let mut repeated_word = word.clone();

        while sequence.contains(&repeated_word) {
            count += 1;
            repeated_word.push_str(&word);
        }

        count
    }
}