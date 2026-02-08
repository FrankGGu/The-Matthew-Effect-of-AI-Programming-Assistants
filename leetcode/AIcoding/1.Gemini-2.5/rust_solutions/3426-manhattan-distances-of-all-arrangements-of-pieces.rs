struct Solution;

const MOD: u64 = 1_000_000_007;
const INV_3: u64 = 333333336; // Modular inverse of 3 modulo 10^9 + 7

fn power(mut base: u64, mut exp: u64, modulus: u64) -> u64 {
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

fn mod_inverse(n: u64, modulus: u64) -> u64 {
    power(n, modulus - 2, modulus)
}

static mut FACTORIALS: Vec<u64> = Vec::new();
static mut INV_FACTORIALS: Vec<u64> = Vec::new();
static mut PRECOMPUTED: bool = false;

fn precompute_factorials_once(modulus: u64) {
    unsafe {
        if PRECOMPUTED { return; }
        FACTORIALS.resize(modulus as usize, 0);
        INV_FACTORIALS.resize(modulus as usize, 0);

        FACTORIALS[0] = 1;
        for i in 1..(modulus as usize) {
            FACTORIALS[i] = (FACTORIALS[i - 1] * i as u64) % modulus;
        }
        INV_FACTORIALS[modulus as usize - 1] = mod_inverse(FACTORIALS[modulus as usize - 1], modulus);
        for i in (1..(modulus as usize - 1)).rev() {
            INV_FACTORIALS[i] = (INV_FACTORIALS[i + 1] * (i + 1) as u64) % modulus;
        }
        PRECOMPUTED = true;
    }
}

fn ncr_lucas(n: u64, r: u64, modulus: u64) -> u64 {
    if r > n {
        return 0;
    }
    if r == 0 || r == n {
        return 1;
    }

    precompute_factorials_once(modulus);

    unsafe {
        let mut res = 1;
        let mut cur_n = n;
        let mut cur_r = r;

        while cur_n > 0 || cur_r > 0 {
            let n_i = cur_n % modulus;
            let r_i = cur_r % modulus;

            if r_i > n_i {
                return 0;
            }

            let term = (FACTORIALS[n_i as usize] * INV_FACTORIALS[r_i as usize]) % modulus;
            let term = (term * INV_FACTORIALS[(n_i - r_i) as usize]) % modulus;
            res = (res * term) % modulus;

            cur_n /= modulus;
            cur_r /= modulus;
        }
        res
    }
}

impl Solution {
    pub fn manhattan_distances(n: i32, k: i32) -> i32 {
        let n_long = n as u64;
        let k_long = k as u64;

        if k_long < 2 {
            return 0;
        }

        let term_n_cub_minus_n = (n_long % MOD * (n_long - 1 + MOD) % MOD * (n_long + 1) % MOD) % MOD;
        let term_n_cub_minus_n = (term_n_cub_minus_n * INV_3) % MOD;

        let n_sq = n_long * n_long;
        let term_n_sq_mod = n_sq % MOD;

        let combinations_val = if n_sq < 2 {
            0
        } else {
            let n_val = n_sq - 2;
            let k_val = k_long - 2;
            ncr_lucas(n_val, k_val, MOD)
        };

        let mut result = (term_n_cub_minus_n * term_n_sq_mod) % MOD;
        result = (result * combinations_val) % MOD;

        result as i32
    }
}