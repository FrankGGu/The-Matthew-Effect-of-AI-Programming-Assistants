impl Solution {
    pub fn simplified_fractions(n: i32) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();

        if n == 1 {
            return result;
        }

        for q in 2..=n {
            for p in 1..q {
                if Self::gcd(p, q) == 1 {
                    result.push(format!("{}/{}", p, q));
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