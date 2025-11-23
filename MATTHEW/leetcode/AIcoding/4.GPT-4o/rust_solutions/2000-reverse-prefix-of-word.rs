impl Solution {
    pub fn reverse_prefix(word: String, ch: char) -> String {
        if let Some(pos) = word.find(ch) {
            let (prefix, suffix) = word.split_at(pos + 1);
            format!("{}{}", prefix.chars().rev().collect::<String>(), suffix)
        } else {
            word
        }
    }
}