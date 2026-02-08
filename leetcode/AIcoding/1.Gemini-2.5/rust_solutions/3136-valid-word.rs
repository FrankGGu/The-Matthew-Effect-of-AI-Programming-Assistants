impl Solution {
    pub fn is_valid(word: String) -> bool {
        if word.len() < 3 {
            return false;
        }

        let mut has_vowel = false;
        let mut has_consonant = false;

        for c in word.chars() {
            if c.is_ascii_alphanumeric() {
                if c.is_ascii_digit() {
                    continue;
                } else if c.is_ascii_alphabetic() {
                    let lower_c = c.to_ascii_lowercase();
                    match lower_c {
                        'a' | 'e' | 'i' | 'o' | 'u' => has_vowel = true,
                        _ => has_consonant = true,
                    }
                }
            } else {
                return false;
            }
        }

        has_vowel && has_consonant
    }
}