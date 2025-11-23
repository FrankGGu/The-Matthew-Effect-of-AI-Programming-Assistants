impl Solution {
    pub fn is_circular_sentence(sentence: String) -> bool {
        let words: Vec<&str> = sentence.split_whitespace().collect();
        if words.is_empty() {
            return true;
        }
        let first_char = words[0].chars().next().unwrap();
        let last_char = words[words.len() - 1].chars().last().unwrap();
        if first_char != last_char {
            return false;
        }
        for i in 0..words.len() - 1 {
            let current_last = words[i].chars().last().unwrap();
            let next_first = words[i + 1].chars().next().unwrap();
            if current_last != next_first {
                return false;
            }
        }
        true
    }
}