var maxValueAfterReverse = function(nums) {
    const n = nums.length;
    let initialValue = 0;
    for (let i = 0; i < n - 1; i++) {
        initialValue += Math.abs(nums[i] - nums[i+1]);
    }

    let maxGain = 0;

    // Case 1: Reverse a subarray starting at index 0 or ending at index n-1.
    // This means one of the original boundary terms is removed, and a new one is added.
    // For example, if we reverse nums[0...k]:
    // Original terms affected: |nums[k] - nums[k+1]| (if k < n-1)
    // New terms affected: |nums[0] - nums[k+1]| (if k < n-1)
    // Gain = |nums[0] - nums[k+1]| - |nums[k] - nums[k+1]|
    // Similarly for reversing nums[j...n-1]:
    // Gain = |nums[j-1] - nums[n-1]| - |nums[j-1] - nums[j]|

    for (let i = 0; i < n - 1; i++) {
        // Reverse subarray [0...i]
        // The original difference |nums[i] - nums[i+1]| is replaced by |nums[0] - nums[i+1]|.
        // The terms inside the reversed segment cancel out.
        // Gain = |nums[0] - nums[i+1]| - |nums[i] - nums[i+1]|
        maxGain = Math.max(maxGain, Math.abs(nums[0] - nums[i+1]) - Math.abs(nums[i] - nums[i+1]));

        // Reverse subarray [i+1...n-1]
        // The original difference |nums[i] - nums[i+1]| is replaced by |nums[i] - nums[n-1]|.
        // Gain = |nums[i] - nums[n-1]| - |nums[i] - nums[i+1]|
        maxGain = Math.max(maxGain, Math.abs(nums[i] - nums[n-1]) - Math.abs(nums[i] - nums[i+1]));
    }

    // Case 2: Reverse a subarray [j...k] where 0 < j <= k < n-1.
    // Let A = nums[j-1], B = nums[j], C = nums[k], D = nums[k+1].
    // The original boundary terms are |A - B| and |C - D|.
    // The new boundary terms are |A - C| and |B - D|.
    // The gain is `(|A - C| + |B - D|) - (|A - B| + |C - D|)`.
    // This expression is equivalent to `2 * max(0, min(A,D) - max(B,C), min(B,C) - max(A,D))`.
    // We need to maximize `min(A,D) - max(B,C)` and `min(B,C) - max(A,D)` over all valid `j, k`.
    // This can be done in O(N) by iterating through `i` and maintaining min/max values.

    // Let's analyze the terms `min(X,Y) - max(Z,W)`.
    // This can be broken into 4 linear forms:
    // (X - Z), (X - W), (Y - Z), (Y - W)
    // We want to maximize these forms.
    // For `min(A,D) - max(B,C)`:
    // This means we want `A` or `D` to be large, and `B` or `C` to be small.
    // The 4 combinations for `min(A,D) - max(B,C)` are:
    // 1. `A - B` (when `A < D` and `B > C`)
    // 2. `A - C` (when `A < D` and `B < C`)
    // 3. `D - B` (when `A > D` and `B > C`)
    // 4. `D - C` (when `A > D` and `B < C`)
    // Similarly for `min(B,C) - max(A,D)`.

    // We can find the maximum of these 8 linear forms by iterating through the array.
    // Let `x_i` be `nums[i]`.
    // The terms are `x_j`, `x_k`, `x_{j-1}`, `x_{k+1}`.
    // We need to maximize `(x_p +/- x_q) - (x_r +/- x_s)`.
    // This suggests keeping track of min/max of `x_i + x_{i+1}` and `x_i - x_{i+1}`.

    let min_val_sum_pair = Infinity; // min(nums[p] + nums[p+1]) for p < i
    let max_val_sum_pair = -Infinity; // max(nums[p] + nums[p+1]) for p < i
    let min_val_diff_pair = Infinity; // min(nums[p] - nums[p+1]) for p < i
    let max_val_diff_pair = -Infinity; // max(nums[p] - nums[p+1]) for p < i

    for (let i = 0; i < n - 1; i++) {
        // For the current pair (nums[i], nums[i+1]), consider it as (A,B) or (C,D).
        // Let `curr_sum = nums[i] + nums[i+1]` and `curr_diff = nums[i] - nums[i+1]`.
        // We are looking for `max((A+D) - (B+C))` or `max((A-D) - (B-C))` etc.
        // This means we are trying to maximize `(current_pair_sum_or_diff) - (previous_pair_sum_or_diff)`.
        // Or `(previous_pair_sum_or_diff) - (current_pair_sum_or_diff)`.

        // Forms of `(X +/- Y) - (Z +/- W)`:
        // 1. `(nums[i] + nums[i+1]) - (nums[p] + nums[p+1])`
        // 2. `(nums[i] + nums[i+1]) - (nums[p] - nums[p+1])`
        // 3. `(nums[i] - nums[i+1]) - (nums[p] + nums[p+1])`
        // 4. `(nums[i] - nums[i+1]) - (nums[p] - nums[p+1])`

        // Maximize `(nums[i] + nums[i+1]) - (nums[p] + nums[p+1])`
        // Current sum `S_curr = nums[i] + nums[i+1]`.
        // Maximize `S_curr - min_val_sum_pair`.
        maxGain = Math.max(maxGain, (nums[i] + nums[i+1]) - min_val_sum_pair);
        // Maximize `(nums[p] + nums[p+1]) - (nums[i] + nums[i+1])`
        // Maximize `max_val_sum_pair - S_curr`.
        maxGain = Math.max(maxGain, max_val_sum_pair - (nums[i] + nums[i+1]));

        // Maximize `(nums[i] - nums[i+1]) - (nums[p] - nums[p+1])`
        // Current diff `D_curr = nums[i] - nums[i+1]`.
        // Maximize `D_curr - min_val_diff_pair`.
        maxGain = Math.max(maxGain, (nums[i] - nums[i+1]) - min_val_diff_pair);
        // Maximize `(nums[p] - nums[p+1]) - (nums[i] - nums[i+1])`
        // Maximize `max_val_diff_pair - D_curr`.
        maxGain = Math.max(maxGain, max_val_diff_pair - (nums[i] - nums[i+1]));

        // Update min/max values for future iterations
        min_val_sum_pair = Math.min(min_val_sum_pair, nums[i] + nums[i+1]);
        max_val_sum_pair = Math.max(max_val_sum_pair, nums[i] + nums[i+1]);
        min_val_diff_pair = Math.min(min_val_diff_pair, nums[i] - nums[i+1]);
        max_val_diff_pair = Math.max(max_val_diff_pair, nums[i] - nums[i+1]);
    }

    return initialValue + maxGain;
};