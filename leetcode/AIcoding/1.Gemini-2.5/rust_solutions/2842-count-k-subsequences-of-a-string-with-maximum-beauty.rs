const MOD: i64 = 1_000_000_007;
const MAX_N_COMB: usize = 26;

static mut FACT: [i64; MAX_N_COMB + 1] = [0; MAX_N_COMB + 1];
static mut INV_FACT: [i64; MAX_N_COMB + 1] = [0; MAX_N_COMB + 1];
static mut INITIALIZED: bool = false;

fn power(mut base: i64, mut exp: i64) -> i64 {
    let mut res = 1;
    base %= MOD;
    while exp > 0 {
        if exp % 2 == 1 {
            res = (res * base) % MOD;
        }
        base = (base * base) % MOD;
        exp /= 2;
    }
    res
}

fn inv(n: i64) -> i64 {
    power(n, MOD - 2)
}

fn precompute_combinations() {
    unsafe {
        if INITIALIZED {
            return;
        }

        FACT[0] = 1;
        for i in 1..=MAX_N_COMB {
            FACT[i] = (FACT[i - 1] * i as i64) % MOD;
        }

        INV_FACT[MAX_N_COMB] = inv(FACT[MAX_N_COMB]);
        for i in (0..MAX_N_COMB).rev() {
            INV_FACT[i] = (INV_FACT[i + 1] * (i + 1) as i64) % MOD;
        }
        INITIALIZED = true;
    }
}

fn ncr_mod_p(n: usize, r: usize) -> i64 {
    if r > n {
        return 0;
    }
    unsafe {
        ((FACT[n] * INV_FACT[r]) % MOD * INV_FACT[n - r]) % MOD
    }
}

struct Solution;

impl Solution {
    pub fn count_k_subsequences_with_max_beauty(s: String, k: i32) -> i32 {
        precompute_combinations();

        let mut freq_map = [0; 26];
        for c in s.chars() {
            freq_map[(c as u8 - b'a') as usize] += 1;
        }

        let mut frequencies: Vec<i32> = freq_map.iter().filter(|&&f| f > 0).cloned().collect();

        if frequencies.len() < k as usize {
            return 0;
        }

        frequencies.sort_unstable_by(|a, b| b.cmp(a));

        let k_usize = k as usize;
        let min_freq_in_top_k = frequencies[k_usize - 1];

        let mut count_greater = 0;
        let mut count_equal = 0;

        for &f in &frequencies {
            if f > min_freq_in_top_k {
                count_greater += 1;
            } else if f == min_freq_in_top_k {
                count_equal += 1;
            }
        }

        let needed_from_equal = k_usize - count_greater;

        ncr_mod_p(count_equal, needed_from_equal) as i32
    }
}