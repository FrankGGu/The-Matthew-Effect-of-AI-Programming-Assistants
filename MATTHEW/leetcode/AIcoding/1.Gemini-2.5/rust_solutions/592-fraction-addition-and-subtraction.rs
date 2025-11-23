struct Solution;

impl Solution {
    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a.abs()
        } else {
            Self::gcd(b, a % b)
        }
    }

    pub fn fraction_addition(expression: String) -> String {
        let mut total_num = 0;
        let mut total_den = 1;

        let chars: Vec<char> = expression.chars().collect();
        let n = chars.len();
        let mut i = 0;

        while i < n {
            let mut sign = 1;
            if chars[i] == '-' {
                sign = -1;
                i += 1;
            } else if chars[i] == '+' {
                i += 1;
            }

            let mut num_str = String::new();
            while i < n && chars[i].is_ascii_digit() {
                num_str.push(chars[i]);
                i += 1;
            }
            let current_num = num_str.parse::<i32>().unwrap() * sign;

            i += 1; // Skip '/'

            let mut den_str = String::new();
            while i < n && chars[i].is_ascii_digit() {
                den_str.push(chars[i]);
                i += 1;
            }
            let current_den = den_str.parse::<i32>().unwrap();

            total_num = total_num * current_den + current_num * total_den;
            total_den = total_den * current_den;

            let common_divisor = Self::gcd(total_num, total_den);
            total_num /= common_divisor;
            total_den /= common_divisor;
        }

        format!("{}/{}", total_num, total_den)
    }
}