impl Solution {
    pub fn number_of_good_subsets(nums: Vec<i32>) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let primes = vec![2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
        let mut freq = vec![0; 31];
        for &num in &nums {
            freq[num as usize] += 1;
        }

        let mut dp = vec![0; 1 << primes.len()];
        dp[0] = 1;

        for num in 2..=30 {
            if freq[num] == 0 {
                continue;
            }
            let mut mask = 0;
            let mut valid = true;
            for (i, &p) in primes.iter().enumerate() {
                if num % (p * p) == 0 {
                    valid = false;
                    break;
                }
                if num % p == 0 {
                    mask |= 1 << i;
                }
            }
            if !valid {
                continue;
            }
            for prev_mask in (0..1 << primes.len()).rev() {
                if (prev_mask & mask) == 0 {
                    dp[prev_mask | mask] = (dp[prev_mask | mask] + dp[prev_mask] as i64 * freq[num] as i64) % MOD as i64;
                }
            }
        }

        let mut res = 0;
        for mask in 1..1 << primes.len() {
            res = (res + dp[mask]) % MOD as i64;
        }

        let mut pow1 = 1;
        for _ in 0..freq[1] {
            pow1 = (pow1 * 2) % MOD;
        }
        res = (res as i64 * pow1 as i64) % MOD as i64;
        res as i32
    }
}