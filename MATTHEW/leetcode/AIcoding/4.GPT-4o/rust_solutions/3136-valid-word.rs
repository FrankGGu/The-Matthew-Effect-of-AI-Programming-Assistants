impl Solution {
    pub fn is_valid_word(word: String, forbidden: Vec<String>) -> bool {
        if forbidden.contains(&word) {
            return false;
        }
        let mut count = 0;
        for c in word.chars() {
            if c.is_alphabetic() {
                count += 1;
            }
        }
        count > 0
    }
}