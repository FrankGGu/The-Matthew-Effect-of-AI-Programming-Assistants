impl Solution {
    pub fn min_non_zero_product(p: i32) -> i32 {
        if p == 1 {
            return 1;
        }
        let modulo = 1_000_000_007;
        let max_num = (1i64 << p) - 1;
        let count = (1i64 << (p - 1)) - 1;

        let pow_result = Self::fast_pow(max_num - 1, count, modulo);
        let result = (max_num % modulo) * pow_result % modulo;

        result as i32
    }

    fn fast_pow(mut base: i64, mut exp: i64, modulo: i64) -> i64 {
        let mut result = 1;
        base %= modulo;
        while exp > 0 {
            if exp % 2 == 1 {
                result = result * base % modulo;
            }
            base = base * base % modulo;
            exp /= 2;
        }
        result
    }
}