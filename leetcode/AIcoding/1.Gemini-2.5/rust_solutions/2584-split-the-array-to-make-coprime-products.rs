use std::collections::{HashMap, HashSet};

const MAX_VAL: usize = 1_000_000;

static mut SPF: Vec<i32> = Vec::new();

pub struct Solution;

impl Solution {
    // Sieve of Eratosthenes to precompute the smallest prime factor (SPF) for each number up to MAX_VAL.
    // SPF[i] stores the smallest prime factor of i.
    fn sieve() {
        unsafe {
            // Only run the sieve if SPF is not already initialized.
            if !SPF.is_empty() {
                return;
            }

            // Initialize SPF array: SPF[i] = i for all i.
            // This means initially, every number is considered its own smallest prime factor (if prime).
            SPF.resize(MAX_VAL + 1, 0);
            for i in 0..=MAX_VAL {
                SPF[i] = i as i32;
            }

            // Iterate from 2 up to MAX_VAL.
            for i in 2..=MAX_VAL {
                // If SPF[i] is still i, it means i is a prime number.
                if SPF[i] == i as i32 {
                    // Mark all multiples of i.
                    // Start from 2*i because i itself is prime and its SPF is i.
                    // We only update SPF[j] if it hasn't been marked by a smaller prime factor yet.
                    for j in (i * 2)..=MAX_VAL {
                        if j % i == 0 && SPF[j] == j as i32 {
                            SPF[j] = i as i32;
                        }
                    }
                }
            }
        }
    }

    // Extracts all distinct prime factors of a given number `n` using the precomputed SPF array.
    fn get_distinct_prime_factors(mut n: i32) -> HashSet<i32> {
        let mut factors = HashSet::new();
        if n <= 1 {
            return factors; // 1 has no prime factors. Numbers <= 0 are not in problem constraints.
        }
        unsafe {
            while n > 1 {
                factors.insert(SPF[n as usize]); // Add the smallest prime factor
                n /= SPF[n as usize];            // Divide n by its smallest prime factor
            }
        }
        factors
    }

    // Main function to find the number of valid split points.
    pub fn find_split_points(nums: Vec<i32>) -> i32 {
        // Ensure the sieve is run exactly once.
        Self::sieve();

        let n = nums.len();
        // A split requires two non-empty subarrays, so n must be at least 2.
        if n < 2 {
            return 0;
        }

        // `total_suffix_factors_counts` stores the counts of distinct prime factors
        // for the entire array initially. As we iterate, it will represent the
        // prime factors of `nums[i+1...n-1]`.
        let mut total_suffix_factors_counts: HashMap<i32, i32> = HashMap::new();
        for &num in nums.iter() {
            for factor in Self::get_distinct_prime_factors(num) {
                *total_suffix_factors_counts.entry(factor).or_insert(0) += 1;
            }
        }

        // `current_prefix_factors_counts` stores the counts of distinct prime factors
        // for the current prefix `nums[0...i]`.
        let mut current_prefix_factors_counts: HashMap<i32, i32> = HashMap::new();
        let mut ans = 0; // Counter for valid split points.

        // Iterate through all possible split points.
        // `i` represents the last index of the first subarray (nums[0...i]).
        // The second subarray will be nums[i+1...n-1].
        // The loop goes up to n-2 because the second subarray must be non-empty.
        for i in 0..n - 1 {
            let num = nums[i];
            let distinct_factors_of_num = Self::get_distinct_prime_factors(num);

            // Update factor counts for both prefix and suffix.
            for factor in &distinct_factors_of_num {
                *current_prefix_factors_counts.entry(*factor).or_insert(0) += 1;

                // Decrement count in suffix. If count becomes 0, remove the factor.
                // This ensures `total_suffix_factors_counts` only contains factors present in the current suffix.
                let count_in_suffix = total_suffix_factors_counts.entry(*factor).or_insert(0);
                *count_in_suffix -= 1;
                if *count_in_suffix == 0 {
                    total_suffix_factors_counts.remove(factor);
                }
            }

            // Check for coprimality:
            // The two products are coprime if their sets of distinct prime factors are disjoint.
            // This means no prime factor in `current_prefix_factors_counts` should be present
            // in `total_suffix_factors_counts`.
            let mut is_coprime = true;
            for factor in current_prefix_factors_counts.keys() {
                if total_suffix_factors_counts.contains_key(factor) {
                    is_coprime = false;
                    break;
                }
            }

            if is_coprime {
                ans += 1;
            }
        }

        ans
    }
}