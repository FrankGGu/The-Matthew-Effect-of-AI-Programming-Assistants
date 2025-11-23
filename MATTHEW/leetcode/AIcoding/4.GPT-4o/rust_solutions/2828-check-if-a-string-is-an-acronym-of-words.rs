impl Solution {
    pub fn is_acronym(words: Vec<String>, s: String) -> bool {
        let acronym: String = words.iter().filter_map(|word| word.chars().next()).collect();
        acronym == s
    }
}