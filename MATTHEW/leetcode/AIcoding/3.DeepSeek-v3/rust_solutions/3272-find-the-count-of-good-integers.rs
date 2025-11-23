impl Solution {
    pub fn count_good_numbers(n: i64) -> i64 {
        const MOD: i64 = 1_000_000_007;

        let even_positions = (n + 1) / 2;
        let odd_positions = n / 2;

        let pow5 = Self::mod_pow(5, even_positions, MOD);
        let pow4 = Self::mod_pow(4, odd_positions, MOD);

        (pow5 * pow4) % MOD
    }

    fn mod_pow(mut base: i64, mut exp: i64, modulus: i64) -> i64 {
        if modulus == 1 {
            return 0;
        }
        let mut result = 1;
        base = base % modulus;
        while exp > 0 {
            if exp % 2 == 1 {
                result = (result * base) % modulus;
            }
            exp = exp >> 1;
            base = (base * base) % modulus;
        }
        result
    }
}