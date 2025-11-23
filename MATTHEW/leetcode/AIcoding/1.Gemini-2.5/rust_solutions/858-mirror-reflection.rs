impl Solution {
    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    pub fn mirror_reflection(p: i32, q: i32) -> i32 {
        let common_divisor = Self::gcd(p, q);
        let n_prime = p / common_divisor;
        let m_prime = q / common_divisor;

        if n_prime % 2 == 1 { // N is odd
            if m_prime % 2 == 1 { // M is odd
                1 // Receiver 1: (p,p)
            } else { // M is even
                0 // Receiver 0: (p,0)
            }
        } else { // N is even
            // If n_prime is even, m_prime must be odd because n_prime and m_prime are coprime.
            2 // Receiver 2: (0,p)
        }
    }
}