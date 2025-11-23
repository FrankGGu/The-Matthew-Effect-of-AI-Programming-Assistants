struct Solution;

impl Solution {
    const MOD: i32 = 1337;

    // Helper function for modular exponentiation (base^exp % MOD)
    fn pow_mod(mut base: i32, mut exp: i32) -> i32 {
        base %= Self::MOD;
        let mut res = 1;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % Self::MOD;
            }
            base = (base * base) % Self::MOD;
            exp /= 2;
        }
        res
    }

    pub fn super_pow(a: i32, b: Vec<i32>) -> i32 {
        let mut res = 1;
        let a_mod = a % Self::MOD; // Reduce 'a' once to prevent overflow and optimize calculations

        // Iterate through the digits of 'b' from left to right
        // The formula used is: a^(d1d2...dk) = (((a^d1)^10 * a^d2)^10 * ... * a^dk) % MOD
        // Or more simply: a^(B) = a^(B' * 10 + last_digit) = (a^B')^10 * a^last_digit
        // Where B' is the number formed by digits before last_digit.
        // In our iterative approach, 'res' accumulates (a^B') and then we apply the next digit.
        for digit in b {
            // For each digit 'd' in 'b', we update 'res' as (res^10 * (a_mod^d)) % MOD
            // 'res^10' effectively shifts the previous result by one decimal place in the exponent.
            // 'a_mod^d' adds the contribution of the current digit.
            res = (Self::pow_mod(res, 10) * Self::pow_mod(a_mod, digit)) % Self::MOD;
        }

        res
    }
}