impl Solution {
    pub fn reformat(s: String) -> String {
        let mut digits: Vec<char> = Vec::new();
        let mut letters: Vec<char> = Vec::new();

        for c in s.chars() {
            if c.is_digit(10) {
                digits.push(c);
            } else {
                letters.push(c);
            }
        }

        if (digits.len() as i32 - letters.len() as i32).abs() > 1 {
            return String::new();
        }

        let mut result = String::new();
        let mut digits_iter = digits.into_iter();
        let mut letters_iter = letters.into_iter();

        if digits.len() > letters.len() {
            while let Some(d) = digits_iter.next() {
                result.push(d);
                if let Some(l) = letters_iter.next() {
                    result.push(l);
                }
            }
        } else {
            while let Some(l) = letters_iter.next() {
                result.push(l);
                if let Some(d) = digits_iter.next() {
                    result.push(d);
                }
            }
        }

        result
    }
}