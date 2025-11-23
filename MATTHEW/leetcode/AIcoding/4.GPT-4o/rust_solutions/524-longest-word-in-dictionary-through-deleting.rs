impl Solution {
    pub fn find_longest_word(s: String, dictionary: Vec<String>) -> String {
        let mut longest = String::new();
        for word in dictionary {
            if Self::can_form_word(&s, &word) {
                if word.len() > longest.len() || (word.len() == longest.len() && word < longest) {
                    longest = word;
                }
            }
        }
        longest
    }

    fn can_form_word(s: &str, word: &str) -> bool {
        let mut s_iter = s.chars();
        let mut word_iter = word.chars();
        let mut current_char = word_iter.next();

        for ch in s_iter {
            if Some(ch) == current_char {
                current_char = word_iter.next();
            }
            if current_char.is_none() {
                return true;
            }
        }
        current_char.is_none()
    }
}