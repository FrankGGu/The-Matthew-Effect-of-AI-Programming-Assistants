impl Solution {
    pub fn ideal_arrays(n: i32, max_value: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let max_value = max_value as usize;
        let n = n as usize;

        let mut dp = vec![vec![0; max_value + 1]; 15];
        for v in 1..=max_value {
            dp[1][v] = 1;
        }

        for l in 1..14 {
            for v in 1..=max_value {
                if dp[l][v] == 0 {
                    continue;
                }
                let mut multiple = 2 * v;
                while multiple <= max_value {
                    dp[l + 1][multiple] = (dp[l + 1][multiple] + dp[l][v]) % MOD;
                    multiple += v;
                }
            }
        }

        let mut fact = vec![1; n + 1];
        for i in 1..=n {
            fact[i] = (fact[i - 1] as i64 * i as i64 % MOD as i64) as i32;
        }

        let mut inv_fact = vec![1; n + 1];
        inv_fact[n] = Self::mod_pow(fact[n] as i64, (MOD - 2) as i64, MOD as i64) as i32;
        for i in (0..n).rev() {
            inv_fact[i] = (inv_fact[i + 1] as i64 * (i + 1) as i64 % MOD as i64) as i32;
        }

        let comb = |a: usize, b: usize| -> i32 {
            if a < b {
                0
            } else {
                fact[a] as i64 * inv_fact[b] as i64 % MOD as i64 * inv_fact[a - b] as i64 % MOD as i64
            } as i32
        };

        let mut res = 0;
        for l in 1..=14.min(n) {
            let mut sum = 0;
            for v in 1..=max_value {
                sum = (sum + dp[l][v]) % MOD;
            }
            res = (res + sum as i64 * comb(n - 1, l - 1) as i64 % MOD as i64) as i32 % MOD;
        }

        res
    }

    fn mod_pow(mut base: i64, mut exp: i64, modulus: i64) -> i64 {
        let mut res = 1;
        base %= modulus;
        while exp > 0 {
            if exp % 2 == 1 {
                res = res * base % modulus;
            }
            base = base * base % modulus;
            exp /= 2;
        }
        res
    }
}