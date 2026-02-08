impl Solution {
    pub fn count_words_with_prefix(words: Vec<String>, prefix: String) -> i32 {
        words.iter().filter(|word| word.starts_with(&prefix)).count() as i32
    }
}