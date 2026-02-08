use std::collections::HashMap;

const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn count_anagrams(s: String) -> i32 {
        let words: Vec<&str> = s.split_whitespace().collect();
        let mut res = 1i64;

        for word in words {
            let mut freq = HashMap::new();
            for c in word.chars() {
                *freq.entry(c).or_insert(0) += 1;
            }

            let mut numerator = factorial(word.len() as i64);
            let mut denominator = 1i64;

            for &count in freq.values() {
                denominator = (denominator * factorial(count as i64)) % MOD;
            }

            let inv_denominator = mod_inverse(denominator, MOD);
            res = (res * numerator) % MOD;
            res = (res * inv_denominator) % MOD;
        }

        res as i32
    }
}

fn factorial(n: i64) -> i64 {
    let mut res = 1i64;
    for i in 1..=n {
        res = (res * i) % MOD;
    }
    res
}

fn mod_inverse(a: i64, m: i64) -> i64 {
    pow_mod(a, m - 2, m)
}

fn pow_mod(mut a: i64, mut b: i64, m: i64) -> i64 {
    let mut res = 1;
    a %= m;
    while b > 0 {
        if b % 2 == 1 {
            res = (res * a) % m;
        }
        a = (a * a) % m;
        b /= 2;
    }
    res
}