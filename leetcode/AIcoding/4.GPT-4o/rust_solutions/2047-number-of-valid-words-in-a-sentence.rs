impl Solution {
    pub fn count_valid_words(sentence: String) -> i32 {
        sentence.split_whitespace().filter(|word| {
            let mut has_punct = false;
            let mut has_digit = false;
            let mut hyphen_count = 0;

            for (i, c) in word.chars().enumerate() {
                if c.is_ascii_digit() {
                    has_digit = true;
                    break;
                }
                if c == '-' {
                    hyphen_count += 1;
                    if hyphen_count > 1 || (i > 0 && (i == word.len() - 1 || !word.chars().nth(i + 1).unwrap().is_ascii_alphabetic() || !word.chars().nth(i - 1).unwrap().is_ascii_alphabetic())) {
                        return false;
                    }
                } else if !c.is_ascii_alphabetic() {
                    if c == '!' || c == '.' || c == ',' {
                        if i != word.len() - 1 {
                            return false;
                        }
                        has_punct = true;
                    } else {
                        return false;
                    }
                }
            }
            !has_digit && (word.len() == 0 || (word.len() > 0 && !(has_punct && word.len() == 1)))
        }).count() as i32
    }
}