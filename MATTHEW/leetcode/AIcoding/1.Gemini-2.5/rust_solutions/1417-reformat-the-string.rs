impl Solution {
    pub fn reformat(s: String) -> String {
        let mut digits: Vec<char> = Vec::new();
        let mut letters: Vec<char> = Vec::new();

        for c in s.chars() {
            if c.is_ascii_digit() {
                digits.push(c);
            } else {
                letters.push(c);
            }
        }

        let n_digits = digits.len();
        let n_letters = letters.len();

        let mut result = String::new();

        if (n_digits as i32 - n_letters as i32).abs() > 1 {
            return "".to_string();
        }

        let mut d_idx = 0;
        let mut l_idx = 0;

        if n_digits > n_letters {
            // Start with digit
            while d_idx < n_digits || l_idx < n_letters {
                if d_idx < n_digits {
                    result.push(digits[d_idx]);
                    d_idx += 1;
                }
                if l_idx < n_letters {
                    result.push(letters[l_idx]);
                    l_idx += 1;
                }
            }
        } else {
            // Start with letter (or if equal lengths)
            while l_idx < n_letters || d_idx < n_digits {
                if l_idx < n_letters {
                    result.push(letters[l_idx]);
                    l_idx += 1;
                }
                if d_idx < n_digits {
                    result.push(digits[d_idx]);
                    d_idx += 1;
                }
            }
        }

        result
    }
}