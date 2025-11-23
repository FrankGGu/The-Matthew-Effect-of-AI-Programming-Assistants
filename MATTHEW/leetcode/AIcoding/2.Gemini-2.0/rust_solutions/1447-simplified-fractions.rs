impl Solution {
    pub fn simplified_fractions(n: i32) -> Vec<String> {
        let mut result = Vec::new();
        for denominator in 2..=n {
            for numerator in 1..denominator {
                if Self::gcd(numerator, denominator) == 1 {
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