impl Solution {
    pub fn simplified_fractions(n: i32) -> Vec<String> {
        let mut result = Vec::new();
        for numerator in 1..n {
            for denominator in numerator + 1..=n {
                if gcd(numerator, denominator) == 1 {
                    result.push(format!("{}/{}", numerator, denominator));
                }
            }
        }
        result
    }
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 { a } else { gcd(b, a % b) }
}