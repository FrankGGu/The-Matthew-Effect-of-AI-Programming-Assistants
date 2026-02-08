impl Solution {
    pub fn count_good_numbers(n: i64) -> i32 {
        const MOD: i64 = 1_000_000_007;

        fn fast_pow(mut base: i64, mut exp: i64, mod_val: i64) -> i64 {
            let mut res = 1;
            while exp > 0 {
                if exp % 2 == 1 {
                    res = (res * base) % mod_val;
                }
                base = (base * base) % mod_val;
                exp /= 2;
            }
            res
        }

        let even = (n + 1) / 2;
        let odd = n / 2;
        let ans = (fast_pow(5, even, MOD) * fast_pow(4, odd, MOD)) % MOD;
        ans as i32
    }
}