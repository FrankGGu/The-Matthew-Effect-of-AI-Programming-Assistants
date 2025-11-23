impl Solution {
    pub fn can_be_typed_words(text: String, broken_letters: String) -> i32 {
        let broken: std::collections::HashSet<char> = broken_letters.chars().collect();
        text.split_whitespace()
            .filter(|word| word.chars().all(|c| !broken.contains(&c)))
            .count() as i32
    }
}