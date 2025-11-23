impl Solution {
    pub fn reverse_prefix(word: String, ch: char) -> String {
        if let Some(index) = word.find(ch) {
            let mut chars: Vec<char> = word.chars().collect();
            chars[..=index].reverse();
            chars.into_iter().collect()
        } else {
            word
        }
    }
}