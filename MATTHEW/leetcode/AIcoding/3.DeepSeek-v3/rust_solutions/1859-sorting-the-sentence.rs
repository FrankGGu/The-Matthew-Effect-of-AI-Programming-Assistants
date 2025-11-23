impl Solution {
    pub fn sort_sentence(s: String) -> String {
        let mut words: Vec<&str> = s.split_whitespace().collect();
        words.sort_by_key(|word| word.chars().last().unwrap());
        let sorted: Vec<String> = words
            .iter()
            .map(|word| word[..word.len() - 1].to_string())
            .collect();
        sorted.join(" ")
    }
}