struct Solution;

impl Solution {
    fn power(mut base: i64, mut exp: i64, modulus: i64) -> i64 {
        let mut res = 1;
        base %= modulus;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % modulus;
            }
            base = (base * base) % modulus;
            exp /= 2;
        }
        res
    }

    pub fn min_non_zero_product(p: i32) -> i32 {
        let modulus: i64 = 1_000_000_007;

        // The problem asks to minimize the product of 2^p - 1 elements.
        // The optimal strategy to minimize the product involves creating a specific distribution:
        // 1. One element will have the value (2^p - 1).
        // 2. The remaining (2^p - 2) elements will be split into two groups:
        //    (2^(p-1) - 1) elements will have the value (2^p - 2).
        //    The other (2^(p-1) - 1) elements will have the value 1.
        // This configuration results in a total of (2^(p-1) - 1) + 1 + (2^(p-1) - 1) = 2^p - 1 elements.
        // The product is then (2^p - 1) * (2^p - 2)^(2^(p-1) - 1) * 1^(2^(p-1) - 1).
        // Since 1 raised to any power is 1, the formula simplifies to:
        // (2^p - 1) * (2^p - 2)^(2^(p-1) - 1)

        // Calculate (2^p - 1)
        let val_2p_minus_1 = ((1i64 << p) - 1) % modulus;

        // Calculate (2^p - 2)
        let val_2p_minus_2 = ((1i64 << p) - 2) % modulus;

        // Calculate the exponent for (2^p - 2), which is (2^(p-1) - 1)
        let exp_for_2p_minus_2 = (1i64 << (p - 1)) - 1;

        // Calculate (val_2p_minus_2 ^ exp_for_2p_minus_2) % modulus
        let term_pow = Self::power(val_2p_minus_2, exp_for_2p_minus_2, modulus);

        // Calculate the final product: (val_2p_minus_1 * term_pow) % modulus
        let result = (val_2p_minus_1 * term_pow) % modulus;

        result as i32
    }
}