const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn square_free_subsets(nums: Vec<i32>) -> i32 {
        let primes = vec![2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
        let mut mask_map = vec![0; 31];
        for i in 2..=30 {
            let mut mask = 0;
            let mut num = i;
            let mut is_square_free = true;
            for (j, &p) in primes.iter().enumerate() {
                if num % p == 0 {
                    if num % (p * p) == 0 {
                        is_square_free = false;
                        break;
                    }
                    mask |= 1 << j;
                    num /= p;
                }
            }
            if is_square_free {
                mask_map[i] = mask;
            }
        }

        let mut count = vec![0; 31];
        for &num in &nums {
            if mask_map[num as usize] != 0 {
                count[num as usize] += 1;
            }
        }

        let mut dp = vec![0; 1 << 10];
        dp[0] = 1;

        for i in 2..=30 {
            if count[i] > 0 {
                let mask = mask_map[i];
                for j in (0..(1 << 10)).rev() {
                    if (j & mask) == 0 {
                        dp[j | mask] = (dp[j | mask] + dp[j] * count[i] as i64 % MOD) % MOD;
                    }
                }
            }
        }

        let mut ans = 0;
        for &val in &dp {
            ans = (ans + val) % MOD;
        }

        let one_count = nums.iter().filter(|&&x| x == 1).count() as i64;
        let one_power = Self::power(2, one_count);

        (ans - 1 + MOD) % MOD * one_power % MOD as i32
    }

    fn power(mut base: i64, mut exp: i64) -> i64 {
        let mut res = 1;
        base %= MOD;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp >>= 1;
        }
        res
    }
}