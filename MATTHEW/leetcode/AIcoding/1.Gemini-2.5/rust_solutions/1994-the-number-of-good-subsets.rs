use std::collections::HashMap;

const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn number_of_good_subsets(nums: Vec<i32>) -> i32 {
        let mut counts = vec![0; 31];
        for &num in &nums {
            counts[num as usize] += 1;
        }

        let mut dp = vec![0i64; 1 << 10]; // 10 primes up to 29
        dp[0] = 1; // Represents the empty set

        let primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
        let prime_to_idx: HashMap<i32, usize> = primes
            .iter()
            .enumerate()
            .map(|(i, &p)| (p, i))
            .collect();

        // Iterate through numbers from 2 to 30
        for i in 2..=30 {
            if counts[i as usize] == 0 {
                continue;
            }

            let mut current_num = i;
            let mut p_mask = 0;
            let mut is_square_free = true;

            // Check square-freeness and get prime mask
            for &p in primes.iter() {
                if current_num % p == 0 {
                    p_mask |= (1 << prime_to_idx[&p]);
                    current_num /= p;
                    if current_num % p == 0 { // Not square-free
                        is_square_free = false;
                        break;
                    }
                }
            }

            if !is_square_free {
                continue;
            }

            // Update DP table
            // Iterate masks downwards to avoid using the current number 'i' multiple times
            for mask_idx in (0..(1 << 10)).rev() {
                if dp[mask_idx] > 0 && (mask_idx & p_mask) == 0 { // If no common prime factors
                    let new_mask = mask_idx | p_mask;
                    dp[new_mask] = (dp[new_mask] + dp[mask_idx] * counts[i as usize]) % MOD;
                }
            }
        }

        let mut total_combinations_including_empty = 0i64;
        for mask_idx in 0..(1 << 10) {
            total_combinations_including_empty = (total_combinations_including_empty + dp[mask_idx]) % MOD;
        }

        // Handle the number 1
        // If there are 'k' ones, there are 2^k ways to choose subsets of ones.
        // This effectively multiplies the count of all other good subsets by 2^k.
        if counts[1] > 0 {
            let num_ones = counts[1];
            let mut power_of_two = 1i64;
            for _ in 0..num_ones {
                power_of_two = (power_of_two * 2) % MOD;
            }
            total_combinations_including_empty = (total_combinations_including_empty * power_of_two) % MOD;
        }

        // Subtract 1 because the problem asks for non-empty subsets.
        // The current total_combinations_including_empty includes the overall empty set
        // (empty set of 2-30 numbers combined with empty set of 1s).
        ((total_combinations_including_empty - 1 + MOD) % MOD) as i32
    }
}