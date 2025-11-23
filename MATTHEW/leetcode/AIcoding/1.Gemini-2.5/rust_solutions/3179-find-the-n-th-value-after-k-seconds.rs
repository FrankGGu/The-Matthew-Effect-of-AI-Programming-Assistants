struct Solution;

impl Solution {
    const MOD: i64 = 1_000_000_007;

    fn power(mut base: i64, mut exp: i64) -> i64 {
        let mut res = 1;
        base %= Self::MOD;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % Self::MOD;
            }
            base = (base * base) % Self::MOD;
            exp /= 2;
        }
        res
    }

    fn mod_inverse(n: i64) -> i64 {
        Self::power(n, Self::MOD - 2)
    }

    pub fn find_nth_value_after_k_seconds(n: i32, k: i32) -> i32 {
        let n = n as i64;
        let k = k as i64;

        // The problem can be modeled as finding the (n-1)-th element (0-indexed)
        // after k seconds.
        // Let dp[i][j] be the value of the j-th element after i seconds.
        // dp[0][j] = 1 for all j.
        // dp[i][j] = sum(dp[i-1][0]...dp[i-1][j])
        // This recurrence relation simplifies to dp[i][j] = C(i + j, j),
        // where C(x, y) is the binomial coefficient "x choose y".
        // We need the (n-1)-th element after k seconds, so j = n-1 and i = k.
        // Thus, the result is C(k + (n-1), n-1).
        // This is equivalent to C(k + n - 1, k).

        let N_val = k + n - 1;
        let K_val = k; // Choose k or (n-1), whichever is smaller, for efficiency. k is fine.

        let max_fact_idx = N_val as usize + 1;
        let mut fact = vec![1; max_fact_idx];
        for i in 1..max_fact_idx {
            fact[i] = (fact[i - 1] * i as i64) % Self::MOD;
        }

        // C(N_val, K_val) = N_val! / (K_val! * (N_val - K_val)!) mod P
        //                 = N_val! * (K_val!)^(-1) * ((N_val - K_val)!)^(-1) mod P

        let numerator = fact[N_val as usize];
        let denominator1 = fact[K_val as usize];
        let denominator2 = fact[(N_val - K_val) as usize];

        let inv_denominator1 = Self::mod_inverse(denominator1);
        let inv_denominator2 = Self::mod_inverse(denominator2);

        let result = (numerator * inv_denominator1) % Self::MOD;
        let result = (result * inv_denominator2) % Self::MOD;

        result as i32
    }
}