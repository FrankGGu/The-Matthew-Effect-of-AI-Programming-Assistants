var incremovableSubarrays = function(nums) {
    const n = nums.length;

    // Step 1: Find the longest strictly increasing prefix.
    // `left_limit` is the largest index `k` such that `nums[0...k]` is strictly increasing.
    // If the array is `[1,2,3,4]`, `left_limit` will be `3`.
    // If the array is `[4,3,2,1]`, `left_limit` will be `0`.
    let left_limit = 0;
    while (left_limit < n - 1 && nums[left_limit] < nums[left_limit + 1]) {
        left_limit++;
    }

    // Step 2: Find the smallest index `k` such that `nums[k...n-1]` is strictly increasing.
    // `min_suffix_start_idx` is this `k`.
    // If the array is `[1,2,3,4]`, `min_suffix_start_idx` will be `0`.
    // If the array is `[4,3,2,1]`, `min_suffix_start_idx` will be `3` (since `nums[3]` is `1`).
    let min_suffix_start_idx = n - 1;
    while (min_suffix_start_idx > 0 && nums[min_suffix_start_idx - 1] < nums[min_suffix_start_idx]) {
        min_suffix_start_idx--;
    }

    let ans = 0;
    // `right_ptr` will be used as a two-pointer to efficiently find the starting point
    // of the valid suffix for each `i`. It points to the first element in `nums[min_suffix_start_idx...n-1]`
    // that is greater than `left_val`.
    let right_ptr = min_suffix_start_idx;

    // Iterate through all possible starting points `i` of the subarray to be removed.
    // The prefix `nums[0...i-1]` must be strictly increasing.
    // This condition holds for `i` from `0` up to `left_limit + 1`.
    // If `i = left_limit + 1`, the prefix `nums[0...left_limit]` is strictly increasing.
    // Any `i` greater than `left_limit + 1` would mean `nums[0...i-1]` is not strictly increasing.
    for (let i = 0; i <= left_limit + 1; i++) {
        // `left_val` is the last element of the prefix `nums[0...i-1]`.
        // If `i = 0`, the prefix is empty, so `left_val` is effectively negative infinity.
        const left_val = (i === 0) ? -Infinity : nums[i - 1];

        // Adjust `right_ptr` to find the first index `p` such that `p >= min_suffix_start_idx`
        // and `nums[p] > left_val`.
        // `right_ptr` only moves forward, ensuring an overall O(N) complexity for this inner loop
        // across all iterations of `i`.
        while (right_ptr < n && nums[right_ptr] <= left_val) {
            right_ptr++;
        }

        // Now, we need to count valid `j`'s (end index of the subarray to remove) for the current `i`.
        // A `j` is valid if:
        // 1. `i <= j < n` (The subarray `nums[i...j]` must be a valid subarray)
        // 2. `j >= min_suffix_start_idx - 1` (Ensures `nums[j+1...n-1]` is strictly increasing)
        // 3. `j >= right_ptr - 1` (Ensures `nums[j+1] > left_val` if `j < n-1`. If `j=n-1`, the suffix is empty, so this condition is not applicable.)

        // Combine these conditions to find the minimum possible `j` that satisfies all criteria.
        const j_min_overall = Math.max(i, min_suffix_start_idx - 1, right_ptr - 1);

        // If `j_min_overall` is less than `n`, it means there are valid `j`'s starting from `j_min_overall`
        // up to `n-1`. The number of such `j`'s is `(n-1) - j_min_overall + 1`.
        if (j_min_overall < n) {
            ans += (n - 1) - j_min_overall + 1;
        }
    }

    return ans;
};