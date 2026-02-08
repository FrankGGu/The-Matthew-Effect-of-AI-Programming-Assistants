impl Solution {
    pub fn reverse_prefix(word: String, ch: char) -> String {
        let mut chars: Vec<char> = word.chars().collect();
        if let Some(idx) = chars.iter().position(|&c| c == ch) {
            chars[0..=idx].reverse();
        }
        chars.into_iter().collect()
    }
}