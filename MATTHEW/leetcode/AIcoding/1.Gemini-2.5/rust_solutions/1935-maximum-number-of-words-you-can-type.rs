use std::collections::HashSet;

impl Solution {
    pub fn can_be_typed_words(text: String, broken_letters: String) -> i32 {
        let broken_chars: HashSet<char> = broken_letters.chars().collect();
        let mut typable_words_count = 0;

        for word in text.split_whitespace() {
            let mut can_type_word = true;
            for ch in word.chars() {
                if broken_chars.contains(&ch) {
                    can_type_word = false;
                    break;
                }
            }
            if can_type_word {
                typable_words_count += 1;
            }
        }

        typable_words_count
    }
}