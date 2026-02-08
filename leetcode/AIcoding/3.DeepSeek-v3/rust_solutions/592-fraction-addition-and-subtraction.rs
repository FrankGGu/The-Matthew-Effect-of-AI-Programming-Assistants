use std::cmp::Ordering;

impl Solution {
    pub fn fraction_addition(expression: String) -> String {
        let mut numerator = 0;
        let mut denominator = 1;
        let mut i = 0;
        let bytes = expression.as_bytes();
        let n = bytes.len();

        while i < n {
            let mut sign = 1;
            if bytes[i] == b'-' {
                sign = -1;
                i += 1;
            } else if bytes[i] == b'+' {
                i += 1;
            }

            let mut num = 0;
            while i < n && bytes[i].is_ascii_digit() {
                num = num * 10 + (bytes[i] - b'0') as i32;
                i += 1;
            }
            let num = num * sign;

            i += 1; // skip '/'

            let mut den = 0;
            while i < n && bytes[i].is_ascii_digit() {
                den = den * 10 + (bytes[i] - b'0') as i32;
                i += 1;
            }

            numerator = numerator * den + num * denominator;
            denominator *= den;
        }

        if numerator == 0 {
            return "0/1".to_string();
        }

        let gcd_val = gcd(numerator.abs(), denominator.abs());
        let reduced_num = numerator / gcd_val;
        let reduced_den = denominator / gcd_val;

        format!("{}/{}", reduced_num, reduced_den)
    }
}

fn gcd(a: i32, b: i32) -> i32 {
    match b.cmp(&0) {
        Ordering::Equal => a,
        _ => gcd(b, a % b),
    }
}