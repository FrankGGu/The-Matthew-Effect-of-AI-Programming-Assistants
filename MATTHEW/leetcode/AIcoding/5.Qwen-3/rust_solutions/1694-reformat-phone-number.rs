impl Solution {
    pub fn reformat_number(number: String) -> String {
        let mut chars: Vec<char> = number.chars().filter(|c| c.is_ascii_digit()).collect();
        let n = chars.len();
        let mut result = String::new();
        let mut i = 0;

        while i < n {
            if n - i > 4 {
                result.push(chars[i]);
                result.push(chars[i + 1]);
                result.push(chars[i + 2]);
                result.push('-');
                i += 3;
            } else {
                match n - i {
                    4 => {
                        result.push(chars[i]);
                        result.push(chars[i + 1]);
                        result.push('-');
                        result.push(chars[i + 2]);
                        result.push(chars[i + 3]);
                    },
                    3 => {
                        result.push(chars[i]);
                        result.push(chars[i + 1]);
                        result.push(chars[i + 2]);
                    },
                    2 => {
                        result.push(chars[i]);
                        result.push(chars[i + 1]);
                    },
                    _ => {}
                }
                break;
            }
        }

        result
    }
}