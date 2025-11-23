impl Solution {
    pub fn reformat_phone_number(number: String) -> String {
        let digits: Vec<char> = number.chars().filter(|c| c.is_ascii_digit()).collect();
        let n = digits.len();
        let mut result = String::with_capacity(n + n / 3);

        let mut i = 0;
        while i < n {
            let remaining = n - i;
            if remaining == 4 {
                result.push(digits[i]);
                result.push(digits[i + 1]);
                result.push('-');
                result.push(digits[i + 2]);
                result.push(digits[i + 3]);
                i += 4;
            } else if remaining == 2 || remaining == 3 {
                for _ in 0..remaining {
                    result.push(digits[i]);
                    i += 1;
                }
            } else {
                result.push(digits[i]);
                result.push(digits[i + 1]);
                result.push(digits[i + 2]);
                i += 3;
                if i < n {
                    result.push('-');
                }
            }
        }

        result
    }
}