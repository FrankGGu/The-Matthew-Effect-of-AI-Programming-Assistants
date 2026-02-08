var minSumOfLengths = function(nums, target) {
    const n = nums.length;
    // dp[i] stores the minimum length of a subarray with sum `target`
    // that ends at or before index `i`.
    const dp = new Array(n).fill(Infinity);

    let minTotalLength = Infinity;
    let currentSum = 0;
    // Map to store prefix sum to its latest index: {prefixSum: index}
    const sumToIndex = new Map();
    sumToIndex.set(0, -1); // Base case: sum 0 exists before index 0

    for (let j = 0; j < n; j++) {
        currentSum += nums[j];

        // Propagate the minimum length from the previous index
        if (j > 0) {
            dp[j] = dp[j - 1];
        }

        // Check if a subarray ending at `j` with sum `target` exists
        if (sumToIndex.has(currentSum - target)) {
            const i = sumToIndex.get(currentSum - target); // `i` is the index *before* the start of the subarray
            const currentSubarrayLength = j - i; // Length of subarray nums[i+1 ... j]

            // Update dp[j] with the length of the current subarray if it's smaller
            dp[j] = Math.min(dp[j], currentSubarrayLength);

            // If a valid first subarray (ending at or before `i`) exists,
            // we can form a pair with the current subarray.
            // `dp[i]` gives the minimum length of a subarray ending at or before index `i`.
            // Since `i` is the index *before* the start of `nums[i+1...j]`,
            // `dp[i]` ensures non-overlapping.
            if (i >= 0 && dp[i] !== Infinity) {
                minTotalLength = Math.min(minTotalLength, dp[i] + currentSubarrayLength);
            }
        }

        // Update the map with the current prefix sum and its index
        sumToIndex.set(currentSum, j);
    }

    return minTotalLength === Infinity ? -1 : minTotalLength;
};