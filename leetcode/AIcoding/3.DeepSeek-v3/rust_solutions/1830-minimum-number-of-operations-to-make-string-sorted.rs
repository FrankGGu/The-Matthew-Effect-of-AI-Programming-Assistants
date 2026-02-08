const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn make_string_sorted(s: String) -> i32 {
        let s = s.into_bytes();
        let n = s.len();
        let mut fact = vec![1; n + 1];
        let mut inv_fact = vec![1; n + 1];
        for i in 1..=n {
            fact[i] = (fact[i - 1] as i64 * i as i64 % MOD) as i32;
            inv_fact[i] = Self::mod_pow(fact[i] as i64, MOD - 2) as i32;
        }

        let mut freq = [0; 26];
        for &c in &s {
            freq[(c - b'a') as usize] += 1;
        }

        let mut res = 0;
        for i in 0..n {
            let c = (s[i] - b'a') as usize;
            let mut count = 0;
            for j in 0..c {
                count += freq[j];
            }
            let mut denominator = 1;
            for &f in &freq {
                denominator = (denominator as i64 * fact[f] as i64 % MOD) as i32;
            }
            let temp = (count as i64 * fact[n - i - 1] as i64 % MOD) as i32;
            let temp = (temp as i64 * inv_fact[denominator as usize] as i64 % MOD) as i32;
            res = (res as i64 + temp as i64) % MOD;
            freq[c] -= 1;
        }
        res as i32
    }

    fn mod_pow(mut x: i64, mut y: i64) -> i32 {
        let mut res = 1;
        while y > 0 {
            if y % 2 == 1 {
                res = res * x % MOD;
            }
            x = x * x % MOD;
            y /= 2;
        }
        res as i32
    }
}