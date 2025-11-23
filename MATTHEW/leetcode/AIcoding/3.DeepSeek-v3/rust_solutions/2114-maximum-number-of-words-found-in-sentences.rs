impl Solution {
    pub fn most_words_found(sentences: Vec<String>) -> i32 {
        sentences.iter().map(|s| s.split_whitespace().count()).max().unwrap_or(0) as i32
    }
}