use std::cmp::max;
use std::cmp::min;

impl Solution {
    pub fn max_subarray_sum_divisible_by_k(nums: Vec<i32>, k: i32) -> i64 {
        let k_long = k as i64;

        // dp_min[r] stores the minimum prefix sum `prefix_sums[j]` such that `j % k == r`.
        // `prefix_sums[j]` is the sum of elements from `nums[0]` to `nums[j-1]`.
        // `prefix_sums[0]` is 0 (sum of an empty prefix).
        let mut dp_min = vec![i64::MAX; k as usize];
        dp_min[0] = 0; // Initialize for prefix_sums[0], where index 0 has remainder 0.

        let mut max_overall_sum = i64::MIN;
        let mut current_prefix_sum: i64 = 0;

        // Iterate through the input array, effectively calculating prefix_sums[i+1]
        // and using (i+1) as the current index for remainder calculation.
        for (i, &num) in nums.iter().enumerate() {
            current_prefix_sum += num as i64;

            // The current index in the conceptual `prefix_sums` array is `i + 1`.
            // We need to find `j` such that `(i + 1) % k == j % k`.
            // The modulo operation `(value % k + k) % k` handles negative `value` correctly
            // to always yield a non-negative remainder in `[0, k-1]`.
            let remainder_for_current_idx = ((i + 1) as i64 % k_long + k_long) % k_long;

            // If we have previously seen a `prefix_sums[j]` (stored in `dp_min`)
            // with the same remainder as `(i + 1)`, we can form a valid subarray.
            // The sum of this subarray is `current_prefix_sum - dp_min[remainder_for_current_idx]`.
            // The length of this subarray is `(i + 1) - j`, which is divisible by `k`.
            // `dp_min[remainder]` stores `prefix_sums[j]` for `j <= i`, ensuring non-empty subarrays.
            if dp_min[remainder_for_current_idx as usize] != i64::MAX {
                let current_candidate_sum = current_prefix_sum - dp_min[remainder_for_current_idx as usize];
                max_overall_sum = max(max_overall_sum, current_candidate_sum);
            }

            // Update `dp_min` with the current `current_prefix_sum` for future calculations.
            // This `current_prefix_sum` corresponds to `prefix_sums[i+1]`.
            // By updating after calculation, `dp_min[remainder]` always refers to a `prefix_sums[j]`
            // where `j` is strictly less than the current `(i+1)`.
            dp_min[remainder_for_current_idx as usize] = min(
                dp_min[remainder_for_current_idx as usize],
                current_prefix_sum,
            );
        }

        // If `max_overall_sum` remains `i64::MIN`, it means no valid non-empty subarray
        // with length divisible by `k` was found.
        max_overall_sum
    }
}