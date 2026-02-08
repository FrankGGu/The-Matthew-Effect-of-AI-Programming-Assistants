impl Solution {
    pub fn maximum_xor_product(a: i64, b: i64, n: i32) -> i32 {
        let mut a = a;
        let mut b = b;
        let mut ans = 1i64;
        let mod_val = 1_000_000_007i64;

        for i in (0..n).rev() {
            let bit = 1i64 << i;
            if (a & bit) == (b & bit) {
                if (a ^ bit) * ((b ^ bit)) > a * b {
                    a ^= bit;
                    b ^= bit;
                }
            }
        }

        ans = (a % mod_val * (b % mod_val)) % mod_val;

        ans as i32
    }
}