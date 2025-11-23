impl Solution {
    pub fn num_of_strings(n: i32) -> i32 {
        let n = n as i64;
        let total = Self::pow(26, n, 1000000007);
        let no_love = Self::pow(25, n, 1000000007);
        let no_love_or_ee = Self::pow(24, n, 1000000007);
        let no_love_and_ee = Self::multiply(n - 1, Self::pow(24, n - 2, 1000000007), 1000000007);
        let no_love_or_ll = Self::pow(24, n, 1000000007);
        let no_love_and_ll = Self::multiply(n - 1, Self::pow(24, n - 2, 1000000007), 1000000007);
        let no_love_or_oo = Self::pow(24, n, 1000000007);
        let no_love_and_oo = Self::multiply(n - 1, Self::pow(24, n - 2, 1000000007), 1000000007);

        let no_love_ee_ll = Self::multiply(Self::multiply(n - 1, n - 2, 1000000007), Self::pow(23, n - 3, 1000000007), 1000000007) % 1000000007;
        let no_love_ee_oo = Self::multiply(Self::multiply(n - 1, n - 2, 1000000007), Self::pow(23, n - 3, 1000000007), 1000000007) % 1000000007;
        let no_love_ll_oo = Self::multiply(Self::multiply(n - 1, n - 2, 1000000007), Self::pow(23, n - 3, 1000000007), 1000000007) % 1000000007;

        let no_ee = Self::pow(25, n, 1000000007);
        let no_ll = Self::pow(25, n, 1000000007);
        let no_oo = Self::pow(25, n, 1000000007);

        let no_ee_ll = Self::pow(24, n, 1000000007);
        let no_ee_oo = Self::pow(24, n, 1000000007);
        let no_ll_oo = Self::pow(24, n, 1000000007);

        let no_ee_ll_oo = Self::pow(23, n, 1000000007);

        let result = (total - no_ee - no_ll - no_oo + no_ee_ll + no_ee_oo + no_ll_oo - no_ee_ll_oo + 1000000007 * 10) % 1000000007;
        result as i32
    }

    fn pow(base: i64, exp: i64, modulus: i64) -> i64 {
        let mut res = 1;
        let mut base = base % modulus;
        let mut exp = exp;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % modulus;
            }
            base = (base * base) % modulus;
            exp /= 2;
        }
        res
    }

    fn multiply(a: i64, b: i64, modulus: i64) -> i64 {
        ((a % modulus) * (b % modulus)) % modulus
    }
}

struct Solution;