var maximumScore = function(nums, multipliers) {
    const n = nums.length;
    const m = multipliers.length;

    // dp[i][j] represents the maximum score after performing 'i' operations,
    // having taken 'j' elements from the left side of 'nums'.
    // The number of elements taken from the right side would be 'i - j'.
    // We use 0-indexed operations for multipliers, so multipliers[k] is for the (k+1)-th operation.

    // Space optimized DP: current row (for 'i' operations) only depends on the previous row (for 'i-1' operations).
    // prev_dp stores scores for (i-1) operations.
    // curr_dp stores scores for 'i' operations.
    let prev_dp = new Array(m + 1).fill(-Infinity);
    prev_dp[0] = 0; // Base case: 0 operations, 0 elements from left, score 0.

    // Iterate through each operation from 1 to m
    for (let i = 1; i <= m; i++) {
        let curr_dp = new Array(m + 1).fill(-Infinity);
        const currentMultiplier = multipliers[i - 1]; // Get the multiplier for the current (i-th) operation

        // Iterate through all possible counts of elements taken from the left side
        // 'j' can range from 0 (all 'i' operations took from right) to 'i' (all 'i' operations took from left)
        for (let j = 0; j <= i; j++) {
            let scoreIfLeftTaken = -Infinity;
            // Option 1: The i-th operation took an element from the left.
            // This means (i-1) operations were performed, and (j-1) elements were taken from the left.
            // The element taken from nums is nums[j-1].
            if (j > 0 && prev_dp[j - 1] !== -Infinity) {
                scoreIfLeftTaken = prev_dp[j - 1] + nums[j - 1] * currentMultiplier;
            }

            let scoreIfRightTaken = -Infinity;
            // Option 2: The i-th operation took an element from the right.
            // This means (i-1) operations were performed, and 'j' elements were taken from the left.
            // The number of elements taken from the right before this step was (i-1) - j.
            // The index of the element taken from nums is nums[n - (i - j)].
            // This is valid if at least one element was taken from the right for the current 'i' operations,
            // i.e., (i - j) > 0, which means j < i.
            if (j < i && prev_dp[j] !== -Infinity) {
                const rightElementsTaken = i - j;
                const rightIdxInNums = n - rightElementsTaken;
                scoreIfRightTaken = prev_dp[j] + nums[rightIdxInNums] * currentMultiplier;
            }

            curr_dp[j] = Math.max(scoreIfLeftTaken, scoreIfRightTaken);
        }
        prev_dp = curr_dp; // Update prev_dp to the newly computed curr_dp for the next iteration
    }

    // After 'm' operations, the maximum score will be the maximum value in the last computed row (prev_dp).
    let maxScore = -Infinity;
    for (let j = 0; j <= m; j++) {
        maxScore = Math.max(maxScore, prev_dp[j]);
    }

    return maxScore;
};