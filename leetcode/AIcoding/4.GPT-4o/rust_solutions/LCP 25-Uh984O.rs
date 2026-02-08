impl Solution {
    pub fn can_type(keyboard: String, word: String) -> bool {
        let mut key_set = std::collections::HashSet::new();
        for c in keyboard.chars() {
            key_set.insert(c);
        }
        for c in word.chars() {
            if !key_set.contains(&c) {
                return false;
            }
        }
        true
    }
}