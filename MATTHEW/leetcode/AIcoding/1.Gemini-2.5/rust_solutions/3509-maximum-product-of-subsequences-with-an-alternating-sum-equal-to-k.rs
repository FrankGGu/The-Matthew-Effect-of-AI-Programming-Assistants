use std::f64;

#[derive(Clone, Copy, Debug)]
struct BigProduct {
    log_val: f64,
    val: Option<i64>, // None if product exceeds i64::MAX
}

impl BigProduct {
    // Represents an invalid or unreachable product state.
    // Using f64::NEG_INFINITY for log_val allows proper comparison and acts as a sentinel.
    // val is Some(0) but not used if log_val is NEG_INFINITY.
    const INVALID: BigProduct = BigProduct { log_val: f64::NEG_INFINITY, val: Some(0) };

    // Represents a product of 1 (e.g., for an empty subsequence).
    const ONE: BigProduct = BigProduct { log_val: 0.0, val: Some(1) };

    // Multiplies the current BigProduct by a given number.
    fn multiply(&self, other_num: i64) -> BigProduct {
        if self.log_val == f64::NEG_INFINITY {
            return BigProduct::INVALID;
        }

        let new_log_val = self.log_val + (other_num as f64).log10();

        let new_val = match self.val {
            Some(v) => {
                // Check for positive overflow before multiplication.
                // Since nums[i] >= 1, other_num will always be positive.
                if v > i64::MAX / other_num {
                    None // Product exceeds i64::MAX
                } else {
                    Some(v * other_num)
                }
            },
            None => None, // If already too large, it remains too large.
        };
        BigProduct {
            log_val: new_log_val,
            val: new_val,
        }
    }

    // Returns the maximum of two BigProduct values.
    fn max(&self, other: BigProduct) -> BigProduct {
        // If one is invalid, the other (if valid) is the max.
        if self.log_val == f64::NEG_INFINITY { return other; }
        if other.log_val == f64::NEG_INFINITY { return *self; }

        match (self.val, other.val) {
            (Some(v_self), Some(v_other)) => {
                // Both products fit in i64, compare actual values.
                if v_self > v_other { *self } else { other }
            },
            (Some(_), None) => other, // Other is too large for i64, so it's greater.
            (None, Some(_)) => *self, // Self is too large for i64, so it's greater.
            (None, None) => {
                // Both products are too large for i64, compare their logarithms.
                if self.log_val > other.log_val { *self } else { other }
            },
        }
    }
}

impl Solution {
    pub fn maximum_product_of_subsequences_with_an_alternating_sum_equal_to_k(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();

        // Determine the maximum possible absolute value for the alternating sum.
        // The alternating sum is s_1 - s_2 + s_3 - s_4 + ...
        // Max nums[i] = 1000, Min nums[i] = 1.
        // Max possible sum for a subsequence of length L:
        // If L is odd: ((L-1)/2) * (1000 - 1) + 1000
        // If L is even: (L/2) * (1000 - 1)
        // Max over all L up to N (nums.len()):
        let max_val = 1000;
        let min_val = 1;

        let actual_max_sum_val = if n % 2 == 1 {
            (n / 2) as i32 * (max_val - min_val) + max_val
        } else {
            (n / 2) as i32 * (max_val - min_val)
        };

        // Min possible sum for a subsequence of length L:
        // If L is odd: ((L-1)/2) * (1 - 1000) + 1
        // If L is even: (L/2) * (1 - 1000)
        // Min over all L up to N:
        let actual_min_sum_val = if n % 2 == 1 {
            (n / 2) as i32 * (min_val - max_val) + min_val
        } else {
            (n / 2) as i32 * (min_val - max_val)
        };

        // The offset for DP array indexing.
        // It's the maximum absolute value the sum can take.
        let offset = actual_max_sum_val.max(actual_min_sum_val.abs());

        // If k is outside the possible range of alternating sums, return -1.
        if k > offset || k < -offset {
            return -1;
        }

        // dp[sum_idx] stores (max_prod_odd_len, max_prod_even_len)
        // sum_idx maps `sum` to `sum + offset`.
        let dp_size = (2 * offset + 1) as usize;
        let mut dp: Vec<(BigProduct, BigProduct)> = vec![(BigProduct::INVALID, BigProduct::INVALID); dp_size];

        // Base case: An empty subsequence has sum 0, product 1, and is considered even length.
        dp[offset as usize] = (BigProduct::INVALID, BigProduct::ONE);

        // Iterate through each number in `nums`.
        for &num_i32 in nums.iter() {
            let num = num_i32 as i64;
            // Create a new DP table for updates to avoid using the current `num` multiple times
            // within the same subsequence generation step.
            let mut next_dp = dp.clone(); 

            // Iterate over all possible sum indices.
            for sum_idx in 0..dp_size {
                let current_sum = sum_idx as i32 - offset;

                // Case 1: Extend an odd-length subsequence.
                // The current `num` becomes an even-indexed term, so it's subtracted.
                if dp[sum_idx].0.log_val != f64::NEG_INFINITY { // If there's a valid odd-length subsequence
                    let prev_prod = dp[sum_idx].0;
                    let new_sum = current_sum - num_i32;

                    // Check if the new sum is within the valid range.
                    if new_sum >= -offset && new_sum <= offset {
                        let new_sum_idx = (new_sum + offset) as usize;
                        let new_prod = prev_prod.multiply(num);
                        next_dp[new_sum_idx].1 = next_dp[new_sum_idx].1.max(new_prod);
                    }
                }

                // Case 2: Extend an even-length subsequence.
                // The current `num` becomes an odd-indexed term, so it's added.
                if dp[sum_idx].1.log_val != f64::NEG_INFINITY { // If there's a valid even-length subsequence
                    let prev_prod = dp[sum_idx].1;
                    let new_sum = current_sum + num_i32;

                    // Check if the new sum is within the valid range.
                    if new_sum >= -offset && new_sum <= offset {
                        let new_sum_idx = (new_sum + offset) as usize;
                        let new_prod = prev_prod.multiply(num);
                        next_dp[new_sum_idx].0 = next_dp[new_sum_idx].0.max(new_prod);
                    }
                }
            }
            dp = next_dp; // Update the DP table for the next number.
        }

        // Retrieve the result for the target sum `k`.
        let k_idx = (k + offset) as usize;
        let result_prod = dp[k_idx].0.max(dp[k_idx].1);

        // Return -1 if no such subsequence exists.
        // Otherwise, return the product. If it exceeds i64::MAX, return i64::MAX.
        if result_prod.log_val == f64::NEG_INFINITY {
            -1
        } else {
            result_prod.val.unwrap_or(i64::MAX)
        }
    }
}