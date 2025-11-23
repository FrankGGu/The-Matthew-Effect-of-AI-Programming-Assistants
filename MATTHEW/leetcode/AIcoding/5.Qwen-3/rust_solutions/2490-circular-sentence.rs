impl Solution {
    pub fn is_circular_sentence(sentence: String) -> bool {
        let words: Vec<&str> = sentence.split_whitespace().collect();
        if words.is_empty() {
            return true;
        }
        for i in 0..words.len() {
            let current = words[i];
            let next = words[(i + 1) % words.len()];
            if current.chars().last().unwrap() != next.chars().next().unwrap() {
                return false;
            }
        }
        true
    }
}