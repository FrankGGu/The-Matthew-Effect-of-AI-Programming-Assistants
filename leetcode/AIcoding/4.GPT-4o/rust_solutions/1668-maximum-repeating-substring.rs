impl Solution {
    pub fn max_repeating(sequence: String, word: String) -> i32 {
        let mut count = 0;
        let mut current = word.clone();

        while sequence.contains(&current) {
            count += 1;
            current.push_str(&word);
        }

        count
    }
}