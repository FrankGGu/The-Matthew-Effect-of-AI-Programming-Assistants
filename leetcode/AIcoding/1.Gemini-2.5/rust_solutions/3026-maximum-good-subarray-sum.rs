use std::collections::HashMap;
use std::cmp::max;

impl Solution {
    pub fn maximum_good_subarray_sum(nums: Vec<i32>, k: i32) -> i64 {
        let mut max_good_sum: i64 = i64::MIN;
        let mut current_prefix_sum: i64 = 0;
        let mut min_prefix_sums: HashMap<i32, i64> = HashMap::new();

        for &num_j in nums.iter() {
            // Check for nums[i] == num_j - k
            let target_val1 = num_j - k;
            if let Some(&min_ps_i) = min_prefix_sums.get(&target_val1) {
                let subarray_sum = (current_prefix_sum + num_j as i64) - min_ps_i;
                max_good_sum = max(max_good_sum, subarray_sum);
            }

            // Check for nums[i] == num_j + k
            let target_val2 = num_j + k;
            if let Some(&min_ps_i) = min_prefix_sums.get(&target_val2) {
                let subarray_sum = (current_prefix_sum + num_j as i64) - min_ps_i;
                max_good_sum = max(max_good_sum, subarray_sum);
            }

            // Update min_prefix_sums for num_j
            // We store the prefix sum *before* num_j (i.e., sum of nums[0..j-1]) for num_j.
            // This is `current_prefix_sum` at this point in the loop.
            min_prefix_sums
                .entry(num_j)
                .and_modify(|e| *e = (*e).min(current_prefix_sum))
                .or_insert(current_prefix_sum);

            // Update current_prefix_sum for the next iteration (sum of nums[0..j])
            current_prefix_sum += num_j as i64;
        }

        if max_good_sum == i64::MIN {
            0
        } else {
            max_good_sum
        }
    }
}