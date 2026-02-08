impl Solution {
    pub fn monkey_move(n: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let mut result = 1;
        let mut base = 2;
        let mut exp = n - 2;

        while exp > 0 {
            if exp % 2 == 1 {
                result = (result * base) % MOD;
            }
            base = (base * base) % MOD;
            exp /= 2;
        }

        (result - 2 + MOD) % MOD
    }
}