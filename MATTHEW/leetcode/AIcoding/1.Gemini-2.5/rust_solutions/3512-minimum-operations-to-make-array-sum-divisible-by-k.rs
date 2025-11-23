use std::collections::HashMap;
use std::cmp::min;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut total_sum: i64 = 0;
        for &num in nums.iter() {
            total_sum += num as i64;
        }

        let k_i64 = k as i64;
        let target_remainder = total_sum % k_i64;

        if target_remainder == 0 {
            return 0;
        }

        let mut dp: HashMap<i64, usize> = HashMap::new();
        dp.insert(0, 0); // An empty set has sum 0, 0 elements.

        for &num in nums.iter() {
            let num_mod_k = (num as i64) % k_i64;

            let mut updates: Vec<(i64, usize)> = Vec::new();

            // Collect current states to iterate over to avoid mutable borrow issues
            let current_dp_states: Vec<(i64, usize)> = dp.iter().map(|(&r, &c)| (r, c)).collect();

            for (rem, count) in current_dp_states {
                let new_rem = (rem + num_mod_k) % k_i64;
                let new_count = count + 1;

                if new_count < *dp.get(&new_rem).unwrap_or(&usize::MAX) {
                    updates.push((new_rem, new_count));
                }
            }

            for (rem, count) in updates {
                dp.insert(rem, count);
            }
        }

        match dp.get(&target_remainder) {
            Some(&count) => count as i32,
            None => -1, // Impossible to achieve the target remainder
        }
    }
}