impl Solution {
    pub fn is_valid(word: String) -> bool {
        if word.len() < 3 {
            return false;
        }
        let mut has_vowel = false;
        let mut has_consonant = false;
        for c in word.chars() {
            if !c.is_ascii_alphabetic() && !c.is_digit(10) {
                return false;
            }
            let lower_c = c.to_ascii_lowercase();
            if lower_c == 'a' || lower_c == 'e' || lower_c == 'i' || lower_c == 'o' || lower_c == 'u' {
                has_vowel = true;
            } else if c.is_ascii_alphabetic() {
                has_consonant = true;
            }
        }
        has_vowel && has_consonant
    }
}