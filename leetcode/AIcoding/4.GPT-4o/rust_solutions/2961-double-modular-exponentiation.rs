impl Solution {
    pub fn mod_exp(base: i32, exp: i32, mod_val: i32) -> i32 {
        let mut result = 1;
        let mut base = base % mod_val;
        let mut exp = exp;

        while exp > 0 {
            if exp % 2 == 1 {
                result = (result * base) % mod_val;
            }
            base = (base * base) % mod_val;
            exp /= 2;
        }
        result
    }

    pub fn double_modular_exponentiation(a: i32, b: i32, c: i32, d: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let exp1 = Self::mod_exp(a, b, mod_val);
        let exp2 = Self::mod_exp(c, d, mod_val);
        (exp1 + exp2) % mod_val
    }
}