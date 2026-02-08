impl Solution {
    pub fn max_repeating(sequence: String, word: String) -> i32 {
        let mut max_count = 0;
        let mut count = 0;
        let word_len = word.len();
        let sequence_len = sequence.len();

        while count * word_len < sequence_len {
            let start = count * word_len;
            let end = start + word_len;
            if sequence.get(start..end) == Some(&word) {
                count += 1;
                max_count = max_count.max(count);
            } else {
                count = 0;
            }
        }

        max_count
    }
}