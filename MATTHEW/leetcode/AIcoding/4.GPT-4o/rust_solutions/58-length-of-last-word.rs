impl Solution {
    pub fn length_of_last_word(s: String) -> i32 {
        let words: Vec<&str> = s.trim().split_whitespace().collect();
        words.last().map_or(0, |word| word.len() as i32)
    }
}