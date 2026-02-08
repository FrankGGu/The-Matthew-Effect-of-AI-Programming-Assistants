impl Solution {
    pub fn reverse_prefix(word: String, ch: char) -> String {
        if let Some(idx) = word.find(ch) {
            let mut chars: Vec<char> = word.chars().collect();
            let (left, right) = chars.split_at_mut(idx + 1);
            left.reverse();
            left.iter().chain(right.iter()).collect()
        } else {
            word
        }
    }
}