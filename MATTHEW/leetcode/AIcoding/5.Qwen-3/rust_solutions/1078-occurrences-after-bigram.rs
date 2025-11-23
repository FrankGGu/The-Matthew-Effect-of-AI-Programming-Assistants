struct Solution;

impl Solution {
    pub fn find_occurrences(text: String, first: String, second: String) -> Vec<String> {
        let mut result = Vec::new();
        let words: Vec<&str> = text.split_whitespace().collect();
        for i in 0..words.len() - 2 {
            if words[i] == first && words[i + 1] == second {
                result.push(words[i + 2].to_string());
            }
        }
        result
    }
}