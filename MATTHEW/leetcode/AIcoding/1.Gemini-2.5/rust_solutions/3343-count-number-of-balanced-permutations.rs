struct Solution;

impl Solution {
    pub fn count_balanced_permutations(n: i32) -> i32 {
        let n = n as usize;
        let modulo = 1_000_000_007;

        let n_odd = (n + 1) / 2;
        let n_even = n / 2;

        let factorial_mod = |k: usize, m: i32| -> i32 {
            let mut res = 1;
            for i in 1..=k {
                res = (res as i64 * i as i64 % m as i64) as i32;
            }
            res
        };

        let fact_odd = factorial_mod(n_odd, modulo);
        let fact_even = factorial_mod(n_even, modulo);

        ((fact_odd as i64 * fact_even as i64) % modulo as i64) as i32
    }
}