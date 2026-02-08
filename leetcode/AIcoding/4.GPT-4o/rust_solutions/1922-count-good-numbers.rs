impl Solution {
    pub fn count_good_numbers(n: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let even_count = (n + 1) / 2;
        let odd_count = n / 2;
        let even_result = mod_pow(5, even_count, MOD);
        let odd_result = mod_pow(4, odd_count, MOD);
        (even_result * odd_result) % MOD
    }

    fn mod_pow(base: i32, exp: i32, mod_val: i32) -> i32 {
        let mut result = 1;
        let mut b = base % mod_val;
        let mut e = exp;
        while e > 0 {
            if e % 2 == 1 {
                result = (result * b) % mod_val;
            }
            b = (b * b) % mod_val;
            e /= 2;
        }
        result
    }
}