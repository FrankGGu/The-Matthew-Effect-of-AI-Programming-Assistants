struct Solution;

impl Solution {
    const MOD: i64 = 1_000_000_007;

    fn pow_mod(mut base: i64, mut exp: i64, modulus: i64) -> i64 {
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

    fn inv_mod(n: i64, modulus: i64) -> i64 {
        Self::pow_mod(n, modulus - 2, modulus)
    }

    pub fn count_infection_sequences(n: i32, infected_trees: Vec<i32>) -> i32 {
        let n_long = n as i64;
        let m_long = infected_trees.len() as i64;

        if m_long == n_long {
            return 1;
        }

        let mut max_needed_factorial_len = 0;
        max_needed_factorial_len = max_needed_factorial_len.max(n_long - m_long);
        max_needed_factorial_len = max_needed_factorial_len.max(infected_trees[0] as i64);
        max_needed_factorial_len = max_needed_factorial_len.max(n_long - 1 - infected_trees[m_long as usize - 1] as i64);
        for i in 0..(m_long - 1) {
            max_needed_factorial_len = max_needed_factorial_len.max(
                infected_trees[i as usize + 1] as i64 - infected_trees[i as usize] as i64 - 1
            );
        }

        let mut fact = vec![1; (max_needed_factorial_len + 1) as usize];
        let mut inv_fact = vec![1; (max_needed_factorial_len + 1) as usize];

        for i in 1..=(max_needed_factorial_len as usize) {
            fact[i] = (fact[i - 1] * i as i64) % Self::MOD;
        }
        inv_fact[max_needed_factorial_len as usize] = Self::inv_mod(fact[max_needed_factorial_len as usize], Self::MOD);
        for i in (1..=(max_needed_factorial_len as usize)).rev() {
            inv_fact[i - 1] = (inv_fact[i] * i as i64) % Self::MOD;
        }

        let total_uninfected = n_long - m_long;
        let mut ans = fact[total_uninfected as usize];

        let l_gap = infected_trees[0] as i64;
        ans = (ans * inv_fact[l_gap as usize]) % Self::MOD;

        let r_gap = n_long - 1 - infected_trees[m_long as usize - 1] as i64;
        ans = (ans * inv_fact[r_gap as usize]) % Self::MOD;

        for i in 0..(m_long - 1) {
            let mid_gap = infected_trees[i as usize + 1] as i64 - infected_trees[i as usize] as i64 - 1;
            if mid_gap > 0 {
                ans = (ans * inv_fact[mid_gap as usize]) % Self::MOD;
                ans = (ans * Self::pow_mod(2, mid_gap - 1, Self::MOD)) % Self::MOD;
            }
        }

        ans as i32
    }
}