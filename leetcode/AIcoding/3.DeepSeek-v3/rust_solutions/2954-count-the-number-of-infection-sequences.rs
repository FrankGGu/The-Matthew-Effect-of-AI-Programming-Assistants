impl Solution {
    pub fn number_of_sequence(n: i32, sick: Vec<i32>) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let n = n as usize;
        let mut sick = sick;
        sick.sort();
        let mut fact = vec![1; n + 1];
        for i in 1..=n {
            fact[i] = (fact[i - 1] * i as i64) % MOD;
        }
        let mut inv_fact = vec![1; n + 1];
        inv_fact[n] = Self::mod_pow(fact[n], MOD - 2, MOD);
        for i in (1..n).rev() {
            inv_fact[i] = (inv_fact[i + 1] * (i + 1) as i64) % MOD;
        }
        let mut res = 1;
        let mut total = 0;
        for i in 0..sick.len() {
            let prev = if i == 0 { -1 } else { sick[i - 1] };
            let curr = sick[i];
            let gap = (curr - prev - 1) as usize;
            if gap == 0 {
                continue;
            }
            total += gap;
            if i != 0 && prev + 1 != curr {
                res = (res * Self::mod_pow(2, gap as i64 - 1, MOD)) % MOD;
            }
            res = (res * inv_fact[gap]) % MOD;
        }
        let last_gap = (n as i32 - sick.last().unwrap() - 1) as usize;
        if last_gap > 0 {
            total += last_gap;
            res = (res * inv_fact[last_gap]) % MOD;
        }
        res = (res * fact[total]) % MOD;
        res as i32
    }

    fn mod_pow(mut base: i64, mut exp: i64, modulus: i64) -> i64 {
        let mut res = 1;
        base %= modulus;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % modulus;
            }
            base = (base * base) % modulus;
            exp /= 2;
        }
        res
    }
}