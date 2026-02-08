impl Solution {
    pub fn monkey_move(n: i32) -> i32 {
        let mod_val: i64 = 1_000_000_007;
        let mut result: i64 = 1;
        let mut base: i64 = 2;
        let mut exponent: i64 = n as i64;

        while exponent > 0 {
            if exponent % 2 == 1 {
                result = (result * base) % mod_val;
            }
            base = (base * base) % mod_val;
            exponent /= 2;
        }

        (result - 2 + mod_val) as i32 % (mod_val as i32)
    }
}