impl Solution {
    pub fn ways_to_split(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 3 {
            return 0;
        }

        let mut prefix_sums = vec![0; n];
        prefix_sums[0] = nums[0];
        for k in 1..n {
            prefix_sums[k] = prefix_sums[k - 1] + nums[k];
        }

        let total_sum = prefix_sums[n - 1];
        let mut count = 0;

        // i is the 0-indexed end of the left subarray.
        // j is the 0-indexed end of the middle subarray.
        //
        // left:   nums[0..i]
        // mid:    nums[i+1..j]
        // right:  nums[j+1..n-1]
        //
        // Constraints on i and j:
        // 1. left must be non-empty: i >= 0
        // 2. mid must be non-empty: i + 1 <= j
        // 3. right must be non-empty: j + 1 <= n - 1  => j <= n - 2
        //
        // Combining these: 0 <= i < j <= n - 2
        //
        // The loop for i goes from 0 up to n-3 (inclusive)
        // This ensures there are at least two elements remaining for mid and right subarrays.
        for i in 0..n - 2 {
            let s1 = prefix_sums[i];

            // The slice for j's prefix sums starts at index i + 1 and ends at n - 2.
            // In Rust slice notation, this is prefix_sums[i + 1 .. n - 1].
            let j_search_slice = &prefix_sums[i + 1 .. n - 1];

            // Condition 1: sum(left) <= sum(mid)
            // s1 <= (prefix_sums[j] - s1)
            // 2 * s1 <= prefix_sums[j]
            let min_pj_val = 2 * s1;

            // Condition 2: sum(mid) <= sum(right)
            // (prefix_sums[j] - s1) <= (total_sum - prefix_sums[j])
            // 2 * prefix_sums[j] <= total_sum + s1
            // prefix_sums[j] <= (total_sum + s1) / 2
            let max_pj_val = (total_sum + s1) / 2;

            // If the minimum required prefix sum for j is greater than the maximum allowed,
            // no valid j exists for this i.
            if min_pj_val > max_pj_val {
                continue;
            }

            // Find the first index `k` in `j_search_slice` such that `j_search_slice[k] >= min_pj_val`.
            // This is equivalent to `std::lower_bound`.
            let lower_bound_offset = j_search_slice.partition_point(|&x| x < min_pj_val);

            // Find the first index `k` in `j_search_slice` such that `j_search_slice[k] > max_pj_val`.
            // This is equivalent to `std::upper_bound`.
            let upper_bound_offset = j_search_slice.partition_point(|&x| x <= max_pj_val);

            // The number of valid j's for the current i is the difference between these two offsets.
            // If lower_bound_offset is greater than upper_bound_offset, it means no valid j was found,
            // and the difference will be 0 or negative (which will be clamped to 0 by max(0, ...)).
            // The `partition_point` method ensures `lower_bound_offset <= upper_bound_offset`
            // if there's any overlap in the range.
            count += (upper_bound_offset - lower_bound_offset) as i32;
        }

        count
    }
}