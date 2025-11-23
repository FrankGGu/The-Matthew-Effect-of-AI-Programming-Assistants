impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn simplified_fractions(n: i32) -> Vec<String> {
        let mut result = Vec::new();
        let mut seen = HashSet::new();

        for denominator in 2..=n {
            for numerator in 1..denominator {
                if gcd(numerator, denominator) == 1 {
                    let key = format!("{}/{}", numerator, denominator);
                    if !seen.contains(&key) {
                        seen.insert(key);
                        result.push(key);
                    }
                }
            }
        }

        result
    }
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}
}