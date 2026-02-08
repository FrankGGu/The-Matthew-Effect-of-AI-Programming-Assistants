impl Solution {
    pub fn number_of_good_subsets(nums: Vec<i32>) -> i32 {
        const MOD: i64 = 1_000_000_007;
        const PRIMES: [i32; 10] = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29];

        let mut freq = vec![0; 31];
        for &num in &nums {
            freq[num as usize] += 1;
        }

        let mut dp = vec![0; 1 << PRIMES.len()];
        dp[0] = 1;

        for _ in 0..freq[1] {
            dp[0] = (dp[0] * 2) % MOD;
        }

        for num in 2..=30 {
            if freq[num] == 0 {
                continue;
            }

            let mut mask = 0;
            let mut valid = true;
            let mut x = num;

            for (i, &p) in PRIMES.iter().enumerate() {
                if x % (p * p) == 0 {
                    valid = false;
                    break;
                }
                if x % p == 0 {
                    mask |= 1 << i;
                }
            }

            if !valid {
                continue;
            }

            for state in (0..(1 << PRIMES.len())).rev() {
                if (state & mask) == 0 {
                    dp[state | mask] = (dp[state | mask] + dp[state] * freq[num] as i64) % MOD;
                }
            }
        }

        let mut res = 0;
        for state in 1..(1 << PRIMES.len()) {
            res = (res + dp[state]) % MOD;
        }

        res as i32
    }
}