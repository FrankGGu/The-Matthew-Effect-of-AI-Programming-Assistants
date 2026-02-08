impl Solution {
    pub fn monkey_move(n: i32) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let mut res = 1_i64;
        let mut base = 2_i64;
        let mut n = n as i64;
        while n > 0 {
            if n % 2 == 1 {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            n /= 2;
        }
        ((res - 2 + MOD) % MOD) as i32
    }
}