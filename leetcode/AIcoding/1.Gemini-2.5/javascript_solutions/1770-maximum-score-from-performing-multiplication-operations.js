var maximumScore = function(nums, multipliers) {
    const n = nums.length;
    const m = multipliers.length;

    // dp[j] will store the maximum score after 'k' operations,
    // where 'j' elements have been taken from the left side of nums.
    // This is a space-optimized DP approach, where 'dp' represents the scores
    // for the previous operation (k-1), and 'next_dp' for the current operation (k).
    let dp = new Array(m + 1).fill(-Infinity);
    dp[0] = 0; // Base case: 0 operations, 0 elements taken from left, score is 0.

    // Iterate through each multiplier (each operation)
    // 'k' represents the current operation number (from 1 to m).
    // The multiplier used for this operation is multipliers[k-1].
    for (let k = 1; k <= m; k++) {
        let next_dp = new Array(m + 1).fill(-Infinity); // Initialize scores for the current operation 'k'

        // 'left' represents the number of elements taken from the left side of 'nums'.
        // 'left' can range from 0 up to 'k' (total operations).
        // We iterate 'left' from 'k' down to '0' to ensure that when we calculate
        // next_dp[left], we are using values from dp (previous row) that have not
        // been updated in this current 'k' iteration if we were doing in-place updates.
        // However, since we use 'next_dp' and 'dp' as separate arrays, the order
        // of 'left' iteration (ascending or descending) does not affect correctness.
        // Ascending order is slightly more intuitive.
        for (let left = 0; left <= k; left++) {
            const right_count = k - left; // The number of elements taken from the right side of 'nums'.

            let scoreIfTakeLeft = -Infinity;
            let scoreIfTakeRight = -Infinity;

            // Option 1: Take the 'left'-th element from the left (nums[left-1]).
            // This is possible only if at least one element is taken from the left (left > 0).
            // The previous state would be dp[left-1] (k-1 operations, left-1 from left).
            if (left > 0) {
                scoreIfTakeLeft = dp[left - 1] + nums[left - 1] * multipliers[k - 1];
            }

            // Option 2: Take the 'right_count'-th element from the right (nums[n - right_count]).
            // This is possible only if at least one element is taken from the right (right_count > 0).
            // The previous state would be dp[left] (k-1 operations, left from left).
            if (right_count > 0) {
                // The index for the rightmost element is n-1, second rightmost is n-2, etc.
                // So, for 'right_count' elements taken from the right, the index is n - right_count.
                scoreIfTakeRight = dp[left] + nums[n - right_count] * multipliers[k - 1];
            }

            // The maximum score for the current state (k operations, 'left' elements from left)
            // is the maximum of the two options.
            next_dp[left] = Math.max(scoreIfTakeLeft, scoreIfTakeRight);
        }
        dp = next_dp; // Update dp to be the current_dp for the next iteration.
    }

    // After 'm' operations, 'dp' array contains the maximum scores for all possible
    // counts of elements taken from the left (from 0 to m).
    // The final answer is the maximum value in this 'dp' array.
    let maxScore = -Infinity;
    for (let i = 0; i <= m; i++) {
        maxScore = Math.max(maxScore, dp[i]);
    }

    return maxScore;
};