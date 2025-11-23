use std::collections::HashMap;

impl Solution {
    pub fn count_sub_multisets(nums: Vec<i32>, l: i32, r: i32) -> i32 {
        let mut freq: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let max_r = r as usize;
        let mut dp: Vec<i32> = vec![0; max_r + 1];
        dp[0] = 1; // One way to make sum 0 (empty set)
        let modulo = 1_000_000_007;

        let count_0 = *freq.get(&0).unwrap_or(&0);

        let unique_non_zero_nums: Vec<(i32, i32)> = freq
            .into_iter()
            .filter(|&(num, _)| num != 0)
            .collect();

        for (num, count) in unique_non_zero_nums {
            // This is the generating function approach for bounded knapsack.
            // For each item 'num' with 'count' occurrences, we want to multiply the current polynomial
            // by (1 + x^num + x^(2*num) + ... + x^(count*num)).
            // This is equivalent to multiplying by (1 - x^((count+1)*num)) / (1 - x^num).
            //
            // Step 1: Multiply by 1 / (1 - x^num)
            // This is the standard unbounded knapsack DP: dp[j] += dp[j - num].
            // This computes dp_temp[j] = sum_{k=0 to infinity} dp_old[j - k*num].
            for j in num as usize..=max_r {
                dp[j] = (dp[j] + dp[j - num as usize]) % modulo;
            }

            // Step 2: Multiply by (1 - x^((count+1)*num))
            // This corrects for using more than 'count' occurrences of 'num'.
            // dp_final[j] = dp_temp[j] - dp_temp[j - (count+1)*num].
            // To ensure dp[j - (count+1)*num] refers to dp_temp (not dp_final),
            // we must iterate 'j' downwards.
            let k_limit_val = (count + 1) * num;
            if k_limit_val <= max_r as i32 {
                for j in (k_limit_val as usize..=max_r).rev() {
                    dp[j] = (dp[j] - dp[j - k_limit_val as usize] + modulo) % modulo;
                }
            }
        }

        // After processing all non-zero numbers, dp[s] contains the number of ways to form sum 's'
        // using only non-zero elements.

        // Now, account for '0's.
        // If we have `count_0` zeros, for any sum `S` formed by non-zero elements,
        // we can add `0, 1, ..., count_0` zeros to it.
        // This means each way to form `S` is multiplied by `(count_0 + 1)`.
        let zero_multiplier = (count_0 + 1) % modulo;

        let mut total_ways = 0;
        for s in l as usize..=r as usize {
            total_ways = (total_ways + dp[s]) % modulo;
        }

        // Apply the zero multiplier
        total_ways = (total_ways * zero_multiplier) % modulo;

        total_ways
    }
}