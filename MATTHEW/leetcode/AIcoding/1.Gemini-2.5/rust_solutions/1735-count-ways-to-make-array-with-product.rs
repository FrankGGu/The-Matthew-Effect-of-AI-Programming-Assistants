const MOD: i64 = 1_000_000_007;

const MAX_N_COMB: usize = 100_000 + 60;

static mut FACTORIALS: Vec<i64> = Vec::new();
static mut INV_FACTORIALS: Vec<i64> = Vec::new();

struct Solution;

impl Solution {
    // Modular exponentiation: (base^exp) % MOD
    fn mod_pow(mut base: i64, mut exp: i64) -> i64 {
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

    // Initialize factorials and inverse factorials up to MAX_N_COMB.
    // This function is called once to set up the static arrays.
    fn init_combinations() {
        unsafe {
            // Check if already initialized to prevent re-initialization
            if !FACTORIALS.is_empty() {
                return;
            }

            FACTORIALS.resize(MAX_N_COMB + 1, 0);
            INV_FACTORIALS.resize(MAX_N_COMB + 1, 0);

            FACTORIALS[0] = 1;
            INV_FACTORIALS[0] = 1;

            for i in 1..=MAX_N_COMB {
                FACTORIALS[i] = (FACTORIALS[i - 1] * i as i64) % MOD;
            }

            // Compute inverse factorial for MAX_N_COMB using Fermat's Little Theorem
            INV_FACTORIALS[MAX_N_COMB] = Self::mod_pow(FACTORIALS[MAX_N_COMB], MOD - 2);
            // Compute other inverse factorials iteratively
            for i in (0..MAX_N_COMB).rev() {
                INV_FACTORIALS[i] = (INV_FACTORIALS[i + 1] * (i + 1) as i64) % MOD;
            }
        }
    }

    // Computes nCr % MOD using precomputed factorials and inverse factorials.
    fn ncr(n: usize, r: usize) -> i64 {
        if r > n {
            return 0;
        }
        unsafe {
            let numerator = FACTORIALS[n];
            let denominator = (INV_FACTORIALS[r] * INV_FACTORIALS[n - r]) % MOD;
            (numerator * denominator) % MOD
        }
    }

    pub fn ways_to_create_product_array(k: i32, product: i64) -> i32 {
        // Ensure combinations are initialized
        Self::init_combinations();

        let mut total_ways: i64 = 1;
        let mut current_product = product;
        let k_usize = k as usize;

        // If product is 0, and array elements must be positive integers (standard interpretation),
        // then there are 0 ways.
        if product == 0 {
            return 0;
        }

        // Prime factorization of the product
        let mut d = 2;
        while d * d <= current_product {
            if current_product % d == 0 {
                let mut exponent = 0;
                while current_product % d == 0 {
                    exponent += 1;
                    current_product /= d;
                }
                // For each prime factor p with its exponent 'exponent',
                // we need to distribute 'exponent' identical items into 'k' distinct bins.
                // This is a stars and bars problem: C(exponent + k - 1, k - 1).
                total_ways = (total_ways * Self::ncr(exponent + k_usize - 1, k_usize - 1)) % MOD;
            }
            d += 1;
        }

        // If current_product is still greater than 1, it means it's a prime factor itself.
        if current_product > 1 {
            let exponent = 1; // This prime factor appears once
            total_ways = (total_ways * Self::ncr(exponent + k_usize - 1, k_usize - 1)) % MOD;
        }

        total_ways as i32
    }
}