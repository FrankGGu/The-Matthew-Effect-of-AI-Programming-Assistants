use std::collections::HashMap;

impl Solution {
    pub fn fraction_addition(expression: String) -> String {
        let mut num = 0;
        let mut den = 1;
        let mut sign = 1;
        let mut i = 0;
        let bytes = expression.as_bytes();

        while i < bytes.len() {
            if bytes[i] == b'+' {
                sign = 1;
                i += 1;
            } else if bytes[i] == b'-' {
                sign = -1;
                i += 1;
            }

            let mut j = i;
            while j < bytes.len() && bytes[j] != b'/' {
                j += 1;
            }
            let numerator: i32 = expression[i..j].parse().unwrap();
            i = j + 1;
            j += 1;
            while j < bytes.len() && bytes[j] != b'+' && bytes[j] != b'-' {
                j += 1;
            }
            let denominator: i32 = expression[i..j].parse().unwrap();
            num += sign * numerator * (den / denominator);
            den *= denominator;
            i = j;
        }

        let gcd = Self::gcd(num.abs(), den.abs());
        format!("{}/{}", num / gcd, den / gcd)
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 { a } else { Self::gcd(b, a % b) }
    }
}