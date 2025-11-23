impl Solution {
    pub fn count_valid_words(sentence: String) -> i32 {
        let mut count = 0;
        for word in sentence.split_whitespace() {
            if word.is_empty() {
                continue;
            }
            let mut valid = true;
            let mut hyphen_count = 0;
            let chars: Vec<char> = word.chars().collect();
            let n = chars.len();

            for (i, &c) in chars.iter().enumerate() {
                if c.is_digit(10) {
                    valid = false;
                    break;
                }
                if c == '-' {
                    hyphen_count += 1;
                    if hyphen_count > 1 || i == 0 || i == n - 1 || !chars[i - 1].is_alphabetic() || !chars[i + 1].is_alphabetic() {
                        valid = false;
                        break;
                    }
                }
                if (c == '!' || c == '.' || c == ',') && i != n - 1 {
                    valid = false;
                    break;
                }
            }
            if valid {
                count += 1;
            }
        }
        count
    }
}