impl Solution {
    pub fn count_valid_words(sentence: String) -> i32 {
        sentence.split_whitespace()
            .filter(|&word| {
                if word.is_empty() {
                    return false;
                }
                let mut hyphen_count = 0;
                for (i, c) in word.chars().enumerate() {
                    if c.is_digit(10) {
                        return false;
                    }
                    if c == '-' {
                        hyphen_count += 1;
                        if hyphen_count > 1 {
                            return false;
                        }
                        if i == 0 || i == word.len() - 1 {
                            return false;
                        }
                        if !word.chars().nth(i - 1).unwrap().is_alphabetic() || !word.chars().nth(i + 1).unwrap().is_alphabetic() {
                            return false;
                        }
                    }
                    if c == '!' || c == '.' || c == ',' {
                        if i != word.len() - 1 {
                            return false;
                        }
                    }
                }
                true
            })
            .count() as i32
    }
}