struct Solution;

impl Solution {
    pub fn square_free_subsets(nums: Vec<i32>) -> i32 {
        let modulo = 1_000_000_007;

        let primes = vec![2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
        let num_primes = primes.len();

        let mut prime_masks: Vec<i32> = vec![0; 31];
        for i in 2..=30 {
            let mut temp = i;
            let mut mask = 0;
            let mut is_square_free = true;
            for (j, &p) in primes.iter().enumerate() {
                if temp % p == 0 {
                    let mut count = 0;
                    while temp % p == 0 {
                        temp /= p;
                        count += 1;
                    }
                    if count >= 2 {
                        is_square_free = false;
                        break;
                    }
                    mask |= 1 << j;
                }
            }
            if is_square_free && temp == 1 {
                prime_masks[i as usize] = mask;
            } else {
                prime_masks[i as usize] = -1;
            }
        }

        let mut dp: Vec<i32> = vec![0; 1 << num_primes];
        dp[0] = 1;

        let mut count_ones = 0;

        for num in nums {
            if num == 1 {
                count_ones += 1;
                continue;
            }

            let current_mask = prime_masks[num as usize];
            if current_mask == -1 {
                continue;
            }

            for mask in (0..(1 << num_primes)).rev() {
                if dp[mask] > 0 {
                    if (mask & current_mask) == 0 {
                        let new_mask = mask | current_mask;
                        dp[new_mask] = (dp[new_mask] + dp[mask]) % modulo;
                    }
                }
            }
        }

        let mut total_subsets_from_non_ones: i64 = 0;
        for val in dp {
            total_subsets_from_non_ones = (total_subsets_from_non_ones + val as i64) % modulo as i64;
        }

        let mut power_of_two_for_ones: i64 = 1;
        for _ in 0..count_ones {
            power_of_two_for_ones = (power_of_two_for_ones * 2) % modulo as i64;
        }

        let result = (total_subsets_from_non_ones * power_of_two_for_ones - 1 + modulo as i64) % modulo as i64;
        result as i32
    }
}