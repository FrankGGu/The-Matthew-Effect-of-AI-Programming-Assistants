impl Solution {
    pub fn is_circular_sentence(sentence: String) -> bool {
        let words: Vec<&str> = sentence.split_whitespace().collect();

        if words.is_empty() {
            return false;
        }

        // Condition 2: The last character of the last word is equal to the first character of the first word.
        // This also covers the single-word case where the first and last word are the same.
        if words[0].chars().next().unwrap() != words.last().unwrap().chars().last().unwrap() {
            return false;
        }

        // Condition 1: The last character of a word is equal to the first character of the next word.
        // Iterate through adjacent pairs of words.
        for pair in words.windows(2) {
            let current_word = pair[0];
            let next_word = pair[1];

            if current_word.chars().last().unwrap() != next_word.chars().next().unwrap() {
                return false;
            }
        }

        true
    }
}