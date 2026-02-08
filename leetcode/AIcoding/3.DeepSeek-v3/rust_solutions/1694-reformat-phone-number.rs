impl Solution {
    pub fn reformat_number(number: String) -> String {
        let digits: Vec<char> = number.chars().filter(|c| c.is_digit(10)).collect();
        let n = digits.len();
        let mut result = String::new();
        let mut i = 0;

        while i < n {
            let remaining = n - i;
            if remaining > 4 {
                result.extend(digits[i..i+3].iter());
                result.push('-');
                i += 3;
            } else if remaining == 4 {
                result.extend(digits[i..i+2].iter());
                result.push('-');
                result.extend(digits[i+2..i+4].iter());
                break;
            } else {
                result.extend(digits[i..n].iter());
                break;
            }
        }

        result
    }
}