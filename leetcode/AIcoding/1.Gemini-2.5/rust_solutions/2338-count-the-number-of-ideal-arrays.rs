struct Solution;

const MOD: i32 = 1_000_000_007;

const MAX_COMB_N: usize = 10000 + 10000; // Roughly max_value + n
static mut FACT: Vec<i32> = Vec::new();
static mut INV_FACT: Vec<i32> = Vec::new();
static mut INITIALIZED: bool = false;

fn power(mut base: i32, mut exp: i32) -> i32 {
    let mut res = 1;
    base %= MOD;
    while exp > 0 {
        if exp % 2 == 1 {
            res = (res as i64 * base as i64 % MOD as i64) as i32;
        }
        base = (base as i64 * base as i64 % MOD as i64) as i32;
        exp /= 2;
    }
    res
}

fn inv(n: i32) -> i32 {
    power(n, MOD - 2)
}

fn precompute_factorials() {
    unsafe {
        if INITIALIZED { return; }
        FACT.resize(MAX_COMB_N + 1, 0);
        INV_FACT.resize(MAX_COMB_N + 1, 0);
        FACT[0] = 1;
        INV_FACT[0] = 1;
        for i in 1..=MAX_COMB_N {
            FACT[i] = (FACT[i-1] as i64 * i as i64 % MOD as i64) as i32;
            INV_FACT[i] = inv(FACT[i]);
        }
        INITIALIZED = true;
    }
}

fn ncr_mod_p(n: i32, r: i32) -> i32 {
    if r < 0 || r > n {
        return 0;
    }
    unsafe {
        let num = FACT[n as usize];
        let den = (INV_FACT[r as usize] as i64 * INV_FACT[(n - r) as usize] as i64 % MOD as i64) as i32;
        (num as i64 * den as i64 % MOD as i64) as i32
    }
}

impl Solution {
    pub fn ideal_arrays(n: i32, max_value: i32) -> i32 {
        precompute_factorials();

        if n == 1 {
            return max_value;
        }

        // k_comb represents 'k-1' in C(e + k - 1, k - 1) where k is the number of factors.
        // We are counting ways to write 'p' as a product of 'n-1' factors.
        // So k = n-1. Thus, k-1 = n-2.
        let k_comb = n - 2;

        // Smallest Prime Factor (SPF) sieve
        let mut spf = vec![0; (max_value + 1) as usize];
        for i in 2..=(max_value as usize) {
            if spf[i] == 0 { // i is prime
                for j in (i..=(max_value as usize)).step_by(i) {
                    if spf[j] == 0 {
                        spf[j] = i as i32;
                    }
                }
            }
        }

        // dp_factors[p] stores the number of ways to write 'p' as a product of 'n-1' factors.
        let mut dp_factors = vec![0; (max_value + 1) as usize];
        dp_factors[1] = 1; // 1 can be written as 1 * 1 * ... * 1 (n-1 times).
                           // This corresponds to C(0 + k_comb, k_comb) = C(k_comb, k_comb) = 1.

        for p in 2..=(max_value as usize) {
            let mut temp_p = p as i32;
            let mut current_dp_factors_p = 1;

            while temp_p > 1 {
                let prime = spf[temp_p as usize];
                let mut exponent = 0;
                while temp_p % prime == 0 {
                    exponent += 1;
                    temp_p /= prime;
                }
                // For each prime factor 'prime' with exponent 'exponent',
                // we need to distribute 'exponent' items into 'n-1' bins (the factors).
                // This is a stars and bars problem: C(exponent + (n-1) - 1, (n-1) - 1)
                // which simplifies to C(exponent + n - 2, n - 2) or C(exponent + k_comb, k_comb).
                current_dp_factors_p = (current_dp_factors_p as i64 * ncr_mod_p(exponent + k_comb, k_comb) as i64 % MOD as i64) as i32;
            }
            dp_factors[p] = current_dp_factors_p;
        }

        // prefix_sum_dp_factors[x] = sum_{i=1 to x} dp_factors[i]
        let mut prefix_sum_dp_factors = vec![0; (max_value + 1) as usize];
        for i in 1..=(max_value as usize) {
            prefix_sum_dp_factors[i] = (prefix_sum_dp_factors[i-1] as i64 + dp_factors[i] as i64) % MOD as i64;
        }

        // The total answer is sum_{v=1 to max_value} (sum_{p=1 to max_value/v} dp_factors[p])
        // This is sum_{v=1 to max_value} prefix_sum_dp_factors[max_value/v]
        let mut total_ans = 0;
        for v in 1..=(max_value as usize) {
            total_ans = (total_ans as i64 + prefix_sum_dp_factors[max_value as usize / v] as i64) % MOD as i64;
        }

        total_ans as i32
    }
}