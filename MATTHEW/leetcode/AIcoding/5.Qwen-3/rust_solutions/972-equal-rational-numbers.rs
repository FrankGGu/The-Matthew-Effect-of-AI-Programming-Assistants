impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn is_rational_equal(s: String, t: String) -> bool {
        fn parse_number(s: &str) -> (i64, i64) {
            let mut parts = s.split('(');
            let integer_part = parts.next().unwrap();
            let decimal_part = parts.next().unwrap();

            let mut int = 0;
            for c in integer_part.chars() {
                if c == '.' {
                    break;
                }
                int = int * 10 + (c as i64 - '0' as i64);
            }

            let mut dec = 0;
            let mut denom = 1;
            for c in integer_part.chars() {
                if c == '.' {
                    for c in decimal_part.chars() {
                        dec = dec * 10 + (c as i64 - '0' as i64);
                        denom *= 10;
                    }
                }
            }

            let mut repeat = 0;
            let mut repeat_denom = 1;
            for c in decimal_part.chars() {
                repeat = repeat * 10 + (c as i64 - '0' as i64);
                repeat_denom *= 10;
            }

            let mut num = int * denom + dec;
            let mut den = denom;

            if repeat != 0 {
                let mut temp_num = num;
                let mut temp_den = den;

                let mut temp = repeat;
                let mut temp_den = repeat_denom;

                while temp_den > 1 {
                    temp_den /= 10;
                    temp = temp / 10;
                }

                let gcd = gcd(temp_den, temp_den);
                temp_den /= gcd;
                temp /= gcd;

                num = num * temp_den + temp * den;
                den = den * temp_den;
            }

            let gcd = gcd(den, num);
            (num / gcd, den / gcd)
        }

        fn gcd(a: i64, b: i64) -> i64 {
            if b == 0 {
                a
            } else {
                gcd(b, a % b)
            }
        }

        let (a_num, a_den) = parse_number(&s);
        let (b_num, b_den) = parse_number(&t);

        a_num * b_den == b_num * a_den
    }
}
}