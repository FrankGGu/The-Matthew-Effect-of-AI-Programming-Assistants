impl Solution {
    pub fn max_nice_divisors(prime_factors: i32) -> i32 {
        if prime_factors <= 3 {
            return prime_factors;
        }
        let n = prime_factors as i64;
        let modulo = 1_000_000_007;
        let (mut quotient, mut remainder) = (n / 3, n % 3);
        if remainder == 1 && quotient > 0 {
            quotient -= 1;
            remainder = 4;
        }
        let pow = |mut a: i64, mut b: i64| -> i64 {
            let mut res = 1;
            while b > 0 {
                if b % 2 == 1 {
                    res = (res * a) % modulo;
                }
                a = (a * a) % modulo;
                b /= 2;
            }
            res
        };
        let part1 = pow(3, quotient);
        if remainder == 0 {
            part1 as i32
        } else {
            ((part1 * remainder) % modulo) as i32
        }
    }
}