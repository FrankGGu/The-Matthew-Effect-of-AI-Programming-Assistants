impl Solution {
    pub fn count_valid_words(sentence: String) -> i32 {
        let mut valid_count = 0;
        for word in sentence.split_whitespace() {
            if Self::is_valid_word(word) {
                valid_count += 1;
            }
        }
        valid_count
    }

    fn is_valid_word(word: &str) -> bool {
        if word.is_empty() {
            return false;
        }

        let mut hyphen_count = 0;
        let mut punctuation_count = 0;
        let chars: Vec<char> = word.chars().collect();

        for (i, &c) in chars.iter().enumerate() {
            if c.is_ascii_digit() {
                return false; // Contains a digit
            }

            if c == '-' {
                hyphen_count += 1;
                if hyphen_count > 1 {
                    return false; // More than one hyphen
                }
                // Hyphen must be surrounded by lowercase letters
                if i == 0 || i == chars.len() - 1 {
                    return false; // Hyphen at start or end
                }
                if !chars[i - 1].is_ascii_lowercase() || !chars[i + 1].is_ascii_lowercase() {
                    return false; // Hyphen not surrounded by lowercase letters
                }
            } else if c == '!' || c == '.' || c == ',' {
                punctuation_count += 1;
                if punctuation_count > 1 {
                    return false; // More than one punctuation mark
                }
                // Punctuation must be at the end
                if i != chars.len() - 1 {
                    return false; // Punctuation not at the end
                }
            } else if !c.is_ascii_lowercase() {
                // Character is not a digit, hyphen, punctuation, or lowercase letter
                // This covers any other invalid character (e.g., uppercase, symbols not allowed)
                return false;
            }
        }

        true
    }
}