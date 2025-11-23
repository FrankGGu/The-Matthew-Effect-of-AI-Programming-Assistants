use std::collections::HashMap;

const MOD: i64 = 1_000_000_007;

struct Combinatorics {
    fact: Vec<i64>,
    inv_fact: Vec<i64>,
}

impl Combinatorics {
    fn new(n: usize) -> Self {
        let mut fact = vec![0; n + 1];
        let mut inv_fact = vec![0; n + 1];
        fact[0] = 1;
        inv_fact[0] = 1;
        for i in 1..=n {
            fact[i] = (fact[i - 1] * i as i64) % MOD;
            inv_fact[i] = Self::mod_inv(fact[i]);
        }
        Combinatorics { fact, inv_fact }
    }

    fn mod_pow(base: i64, exp: i64) -> i64 {
        let mut res = 1;
        let mut base = base % MOD;
        let mut exp = exp;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp /= 2;
        }
        res
    }

    fn mod_inv(n: i64) -> i64 {
        Self::mod_pow(n, MOD - 2)
    }

    fn ncr(&self, n: i32, r: i32) -> i64 {
        if r < 0 || r > n {
            0
        } else {
            let n = n as usize;
            let r = r as usize;
            (self.fact[n] * self.inv_fact[r]) % MOD * self.inv_fact[n - r] % MOD
        }
    }
}

impl Solution {
    pub fn subsequences_with_unique_middle_mode_i(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        let mut sorted_nums = nums.clone();
        sorted_nums.sort_unstable();
        let median_val = sorted_nums[(n - 1) / 2];

        let mut freq_map: HashMap<i32, i32> = HashMap::new();
        for &num in nums.iter() {
            *freq_map.entry(num).or_insert(0) += 1;
        }

        let c_m = *freq_map.get(&median_val).unwrap_or(&0);
        if c_m == 0 {
            return 0;
        }

        let combinatorics = Combinatorics::new(n);

        let mut total_subsequences: i64 = 0;

        for k in 1..=c_m {
            let ways_median = combinatorics.ncr(c_m, k);
            let mut ways_others: i64 = 1;

            for (&x, &c_x) in freq_map.iter() {
                if x == median_val {
                    continue;
                }

                let mut sum_choices_for_x: i64 = 0;
                let upper_bound = (k - 1).min(c_x);
                for j in 0..=upper_bound {
                    sum_choices_for_x = (sum_choices_for_x + combinatorics.ncr(c_x, j)) % MOD;
                }
                ways_others = (ways_others * sum_choices_for_x) % MOD;
            }
            total_subsequences = (total_subsequences + ways_median * ways_others) % MOD;
        }

        total_subsequences as i32
    }
}