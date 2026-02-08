const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn number_of_sequence(n: i32, m: i32) -> i32 {
        let n = n as i64;
        let m = m as i64;
        let healthy = n - m;

        if healthy == 0 {
            return 1;
        }

        let mut fact = vec![1; (n + 1) as usize];
        for i in 2..=(n as usize) {
            fact[i] = (fact[i - 1] * i as i64) % MOD;
        }

        let inv_m = Self::power(fact[m as usize], MOD - 2);
        let inv_healthy = Self::power(fact[healthy as usize], MOD - 2);
        let inv_n_minus_1 = Self::power(fact[(n - 1) as usize], MOD - 2);

        let comb_n_m = fact[n as usize] * Self::power(fact[m as usize], MOD - 2) % MOD * Self::power(fact[healthy as usize], MOD - 2) % MOD;
        let comb_n_minus_1_m_minus_1 = fact[(n - 1) as usize] * Self::power(fact[(m - 1) as usize], MOD - 2) % MOD * Self::power(fact[(n - m) as usize], MOD - 2) % MOD;

        ((comb_n_m * Self::power(2, m - 1) % MOD) as i32)
    }

    fn power(mut base: i64, mut exp: i64) -> i64 {
        let mut res: i64 = 1;
        base %= MOD;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp >>= 1;
        }
        res
    }
}