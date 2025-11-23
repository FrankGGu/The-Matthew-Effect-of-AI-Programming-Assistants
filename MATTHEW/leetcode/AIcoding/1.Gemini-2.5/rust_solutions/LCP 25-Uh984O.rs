use std::collections::HashSet;

impl Solution {
    pub fn can_be_typed_words(text: String, broken_keys: String) -> i32 {
        let broken_chars: HashSet<char> = broken_keys.chars().collect();
        let mut count = 0;

        for word in text.split_whitespace() {
            let mut typable = true;
            for ch in word.chars() {
                if broken_chars.contains(&ch) {
                    typable = false;
                    break;
                }
            }
            if typable {
                count += 1;
            }
        }
        count
    }
}