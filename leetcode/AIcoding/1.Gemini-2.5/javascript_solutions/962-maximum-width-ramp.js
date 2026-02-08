var maxWidthRamp = function(nums) {
    const n = nums.length;
    let maxWidth = 0;
    const stack = []; // Stores indices i such that nums[i] is decreasing

    // Step 1: Build a stack of candidate 'i' indices.
    // The stack will contain indices `idx_0, idx_1, ..., idx_k` such that
    // idx_0 < idx_1 < ... < idx_k and nums[idx_0] > nums[idx_1] > ... > nums[idx_k].
    // These are potential starting points of ramps because they are small indices
    // with relatively small values, making it easier to find a `j` where `nums[j] >= nums[i]`.
    for (let i = 0; i < n; i++) {
        if (stack.length === 0 || nums[i] < nums[stack[stack.length - 1]]) {
            stack.push(i);
        }
    }

    // Step 2: Iterate 'j' from right to left to find the maximum width.
    // For each `nums[j]`, we try to find the smallest `i` from the stack
    // such that `nums[i] <= nums[j]`.
    // Since `j` decreases, we ensure that for a given `i`, we find the largest possible `j`.
    for (let j = n - 1; j >= 0; j--) {
        // While the stack is not empty and the value at the top of the stack (nums[i])
        // is less than or equal to nums[j], we have found a valid ramp (i, j).
        // We pop 'i' because we've found the largest possible 'j' for this 'i'
        // (since 'j' is iterated downwards). Popping 'i' also reveals a smaller index
        // which could potentially yield an even larger width `j - i'`.
        while (stack.length > 0 && nums[stack[stack.length - 1]] <= nums[j]) {
            const i = stack.pop();
            maxWidth = Math.max(maxWidth, j - i);
        }
    }

    return maxWidth;
};