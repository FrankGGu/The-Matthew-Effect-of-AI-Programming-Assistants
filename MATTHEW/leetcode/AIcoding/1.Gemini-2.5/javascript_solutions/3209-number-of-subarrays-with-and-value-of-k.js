var subarraysWithAndValue = function(nums, k) {
    let count = 0;
    // dp stores a map of (AND_value -> count) for subarrays ending at the previous index.
    // For example, dp = {5: 2, 1: 3} means there are 2 subarrays ending at (j-1) with AND value 5,
    // and 3 subarrays ending at (j-1) with AND value 1.
    let dp = new Map();

    for (let j = 0; j < nums.length; j++) {
        let new_dp = new Map();

        // Subarray of length 1 ending at j: [nums[j]]
        // Its AND value is nums[j].
        new_dp.set(nums[j], (new_dp.get(nums[j]) || 0) + 1);

        // Extend subarrays from previous index (j-1)
        // For each (prev_and_val, prev_count) in dp:
        // These prev_count subarrays ended at (j-1) with AND value prev_and_val.
        // When extended to j, their new AND value is prev_and_val & nums[j].
        for (let [prev_and_val, prev_count] of dp.entries()) {
            let current_and_val = prev_and_val & nums[j];
            new_dp.set(current_and_val, (new_dp.get(current_and_val) || 0) + prev_count);
        }

        // Update dp for the next iteration
        dp = new_dp;

        // Add counts of subarrays with AND value k ending at current index j
        count += dp.get(k) || 0;
    }

    return count;
};