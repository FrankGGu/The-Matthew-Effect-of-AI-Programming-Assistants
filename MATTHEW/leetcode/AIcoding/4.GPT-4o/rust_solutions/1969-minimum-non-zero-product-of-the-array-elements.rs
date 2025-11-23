impl Solution {
    pub fn min_non_zero_product(prime: i32, n: i32) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let max_num = (1 << n) - 1;
        let max_prime = prime.pow(n as u32);
        let result = (max_prime - 1) % MOD * (max_prime / prime) % MOD;
        result as i32
    }
}