impl Solution {
    pub fn find_occurrences(text: String, first: String, second: String) -> Vec<String> {
        let words: Vec<&str> = text.split_whitespace().collect();
        let mut result: Vec<String> = Vec::new();

        for i in 0..words.len() {
            if i + 2 < words.len() {
                if words[i] == first && words[i+1] == second {
                    result.push(words[i+2].to_string());
                }
            }
        }
        result
    }
}