use std::str::FromStr;

impl Solution {
    pub fn is_rational_equal(s: String, t: String) -> bool {
        fn parse(s: &str) -> (i64, i64) {
            let parts: Vec<&str> = s.split('.').collect();
            let integer_part = i64::from_str(parts[0]).unwrap();
            if parts.len() == 1 {
                return (integer_part, 1);
            }
            let decimal_part = parts[1];
            let mut non_repeating = String::new();
            let mut repeating = String::new();
            let mut in_repeating = false;
            for c in decimal_part.chars() {
                if c == '(' {
                    in_repeating = true;
                } else if c == ')' {
                    continue;
                } else if in_repeating {
                    repeating.push(c);
                } else {
                    non_repeating.push(c);
                }
            }
            let non_repeating_len = non_repeating.len() as u32;
            let repeating_len = repeating.len() as u32;
            let mut denominator = 10i64.pow(non_repeating_len);
            let mut numerator = if non_repeating.is_empty() {
                0
            } else {
                i64::from_str(&non_repeating).unwrap()
            };
            if repeating_len > 0 {
                let repeating_num = i64::from_str(&repeating).unwrap();
                numerator = numerator * 10i64.pow(repeating_len) + repeating_num - numerator;
                denominator *= 10i64.pow(repeating_len) - 1;
            }
            let numerator_total = integer_part * denominator + numerator;
            let gcd_val = gcd(numerator_total, denominator);
            (numerator_total / gcd_val, denominator / gcd_val)
        }

        fn gcd(a: i64, b: i64) -> i64 {
            if b == 0 { a } else { gcd(b, a % b) }
        }

        let (n1, d1) = parse(&s);
        let (n2, d2) = parse(&t);
        n1 == n2 && d1 == d2
    }
}