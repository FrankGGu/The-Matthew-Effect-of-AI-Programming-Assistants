var maximizeTotalCost = function(nums) {
    const n = nums.length;

    // dp[i][0] represents the maximum total cost for nums[0...i]
    // where nums[i] is the last element of its alternating subarray and contributes +nums[i] to its subarray's cost.
    // dp[i][1] represents the maximum total cost for nums[0...i]
    // where nums[i] is the last element of its alternating subarray and contributes -nums[i] to its subarray's cost.
    const dp = Array(n).fill(0).map(() => Array(2).fill(Number.NEGATIVE_INFINITY));

    // Base case for i = 0
    // A single element subarray [nums[0]] has cost nums[0]. It contributes positively.
    dp[0][0] = nums[0];
    // dp[0][1] remains Number.NEGATIVE_INFINITY as a single element subarray cannot contribute negatively.

    for (let i = 1; i < n; i++) {
        // Calculate dp[i][0] (maximum total cost ending with +nums[i])
        // Option 1: nums[i] starts a new alternating subarray [nums[i]].
        // The total cost is the maximum total cost achieved up to index i-1, plus nums[i].
        let costIfStartNew = Math.max(dp[i-1][0], dp[i-1][1]) + nums[i];

        // Option 2: nums[i] extends an existing alternating subarray.
        // For nums[i] to contribute positively, the previous element nums[i-1] must have contributed negatively.
        // The alternating condition requires nums[i-1] < nums[i].
        let costIfExtendPrevNeg = Number.NEGATIVE_INFINITY;
        if (nums[i-1] < nums[i]) {
            costIfExtendPrevNeg = dp[i-1][1] + nums[i];
        }
        dp[i][0] = Math.max(costIfStartNew, costIfExtendPrevNeg);

        // Calculate dp[i][1] (maximum total cost ending with -nums[i])
        // Option 1: nums[i] starts a new alternating subarray. This is not possible for a negative contribution.
        // Option 2: nums[i] extends an existing alternating subarray.
        // For nums[i] to contribute negatively, the previous element nums[i-1] must have contributed positively.
        // The alternating condition requires nums[i-1] > nums[i].
        let costIfExtendPrevPos = Number.NEGATIVE_INFINITY;
        if (nums[i-1] > nums[i]) {
            costIfExtendPrevPos = dp[i-1][0] - nums[i];
        }
        dp[i][1] = costIfExtendPrevPos; // Only one valid option (extension) for negative contribution
    }

    // The maximum total cost is the maximum of the two possibilities for the last element.
    return Math.max(dp[n-1][0], dp[n-1][1]);
};