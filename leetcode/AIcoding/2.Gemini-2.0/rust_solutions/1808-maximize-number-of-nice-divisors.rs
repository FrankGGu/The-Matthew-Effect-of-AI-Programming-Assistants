impl Solution {
    pub fn max_nice_divisors(prime_factors: i32) -> i32 {
        let n = prime_factors as i64;
        if n <= 3 {
            return n as i32;
        }
        let a = n / 3;
        let b = n % 3;
        let mut res = 1;
        if b == 0 {
            res = Solution::pow(3, a, 1000000007);
        } else if b == 1 {
            res = Solution::pow(3, a - 1, 1000000007) * 4 % 1000000007;
        } else {
            res = Solution::pow(3, a, 1000000007) * 2 % 1000000007;
        }
        res as i32
    }

    fn pow(base: i64, exp: i64, modulo: i64) -> i64 {
        let mut res = 1;
        let mut base = base % modulo;
        let mut exp = exp;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % modulo;
            }
            base = (base * base) % modulo;
            exp /= 2;
        }
        res
    }
}