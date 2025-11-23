struct Solution;

impl Solution {
    pub fn split_words_by_separator(words: Vec<String>, separator: char) -> Vec<String> {
        words
            .into_iter()
            .flat_map(|word| {
                word.split(separator)
                    .filter(|s| !s.is_empty())
                    .map(|s| s.to_string())
            })
            .collect()
    }
}