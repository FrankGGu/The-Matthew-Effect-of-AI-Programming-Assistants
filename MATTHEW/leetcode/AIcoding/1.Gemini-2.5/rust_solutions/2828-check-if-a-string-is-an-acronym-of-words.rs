impl Solution {
    pub fn is_acronym(words: Vec<String>, s: String) -> bool {
        let first_chars_of_words = words.iter()
                                        .map(|word| word.chars().next().unwrap());

        s.chars().eq(first_chars_of_words)
    }
}