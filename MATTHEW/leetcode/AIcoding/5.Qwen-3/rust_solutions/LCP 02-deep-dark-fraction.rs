impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn simplified_fractions(mut n: i32) -> Vec<String> {
        let mut result = Vec::new();
        let mut seen = HashMap::new();

        for denominator in 2..=n {
            for numerator in 1..denominator {
                let gcd = Self::gcd(numerator, denominator);
                let reduced_num = numerator / gcd;
                let reduced_den = denominator / gcd;

                let key = format!("{}{}", reduced_num, reduced_den);
                if !seen.contains_key(&key) {
                    seen.insert(key, ());
                    result.push(format!("{}/{}", numerator, denominator));
                }
            }
        }

        result
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}
}