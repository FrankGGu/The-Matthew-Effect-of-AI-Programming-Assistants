use std::collections::HashMap;
use std::cmp::min;

const MAX_XOR_VAL: usize = 1024; // Values are < 2^10, so XOR sum will also be < 2^10

impl Solution {
    pub fn min_changes(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;

        // dp[xor_sum] stores the minimum changes to achieve `xor_sum` for the groups processed so far.
        // Initialize with a value larger than any possible changes (n + 1).
        // Using i32::MAX as INF is also an option, but n+1 is sufficient and avoids potential overflow issues
        // if adding group_size to i32::MAX.
        let mut dp = vec![n as i32 + 1; MAX_XOR_VAL];
        dp[0] = 0; // Base case: 0 groups processed, 0 changes, XOR sum 0

        for i in 0..k {
            // Collect elements for the current group (nums[i], nums[i+k], nums[i+2k], ...)
            let mut group_counts: HashMap<i32, i32> = HashMap::new();
            let mut group_size = 0;
            let mut j = i;
            while j < n {
                *group_counts.entry(nums[j]).or_insert(0) += 1;
                group_size += 1;
                j += k;
            }

            // Find the minimum changes from the previous DP state.
            // This represents the minimum cost to achieve *any* XOR sum from previous groups.
            let min_prev_dp_val = *dp.iter().min().unwrap();

            // Initialize new_dp for the current group.
            // This covers the "default" case: we change all elements in the current group to a value
            // that is NOT present in the group.
            // The cost for this group would be `group_size`.
            // So, for any target_xor_sum, we can achieve it by combining `min_prev_dp_val` (from previous groups)
            // with an `x_i` (for the current group) that is not in `group_counts`.
            // This costs `min_prev_dp_val + group_size`.
            let mut new_dp = vec![min_prev_dp_val + group_size; MAX_XOR_VAL];

            // Iterate through previous XOR sums
            for prev_xor_sum in 0..MAX_XOR_VAL {
                // If the previous XOR sum was unreachable, skip it.
                if dp[prev_xor_sum] >= n as i32 + 1 {
                    continue;
                }

                // Iterate through distinct values present in the current group.
                // This covers the case: we change elements in the current group to a value `v`
                // that IS present in the group.
                for (&val_in_group, &count_val) in &group_counts {
                    let cost_for_this_group = group_size - count_val;
                    let current_xor_sum = prev_xor_sum ^ (val_in_group as usize);

                    // Update new_dp[current_xor_sum] with the minimum of its current value
                    // and the cost of reaching it via `prev_xor_sum` and `val_in_group`.
                    new_dp[current_xor_sum] = min(new_dp[current_xor_sum], dp[prev_xor_sum] + cost_for_this_group);
                }
            }
            dp = new_dp; // Update dp for the next iteration
        }

        // The final answer is the minimum changes to make the total XOR sum 0.
        dp[0]
    }
}