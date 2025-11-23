impl Solution {

use std::cmp::min;

impl Solution {
    pub fn min_non_zero_product(a: i32) -> i32 {
        const MOD: i64 = 10_i64.pow(9) + 7;
        let mut result = 1;
        let mut n = a;
        let mut m = 1;
        while m < n {
            let p = (n - m) % MOD;
            let q = (m - 1) % MOD;
            let power = (p * q) % MOD;
            result = (result * power) % MOD;
            m += 1;
        }
        result
    }
}
}