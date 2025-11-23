var findMaximumLength = function(nums) {
    const n = nums.length;

    // dp[k] stores the minimum possible sum of the k-th segment
    // if we can form a non-decreasing array of length k.
    // dp[0] is a sentinel value representing the sum before the first segment,
    // effectively allowing any first segment.
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    // prefixSum[i] stores the sum of nums[0...i-1].
    // prefixSum[0] = 0.
    // prefixSum[i+1] = nums[0] + ... + nums[i].
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    // `j` is a pointer that helps find the optimal previous state.
    // It represents a length `k` such that `dp[k] + prefixSum[k]` is minimized and less than or equal to `currentPrefixSum`.
    let j = 0; 
    // `currentMaxLen` tracks the maximum length of a non-decreasing array found so far.
    let currentMaxLen = 0;

    // Iterate through the input array `nums`. `i` represents the end index of the current segment being considered.
    for (let i = 0; i < n; i++) {
        const currentPrefixSum = prefixSum[i + 1]; // Sum of nums[0...i]

        // Advance `j` to find the largest length `k` (represented by `j`)
        // such that `dp[k] + prefixSum[k] <= currentPrefixSum`.
        // `dp[k]` is the minimum sum of the `k`-th segment.
        // `prefixSum[k]` is the sum of elements before the `k`-th segment.
        // So `dp[k] + prefixSum[k]` represents the total sum of the first `k` segments.
        // We want this total sum to be less than or equal to `currentPrefixSum`
        // to ensure the non-decreasing property when adding a new segment.
        while (j <= currentMaxLen && dp[j] + prefixSum[j] <= currentPrefixSum) {
            j++;
        }
        // After the loop, `j-1` is the largest length `k` for which `dp[k] + prefixSum[k] <= currentPrefixSum`.
        // This means we can form a new non-decreasing array of length `j`.
        // The sum of this new segment (the `j`-th segment) would be `currentPrefixSum - prefixSum[j-1]`.
        const newSegmentSum = currentPrefixSum - prefixSum[j - 1];

        // Update `dp[j]` with this new segment sum if it's smaller.
        // `dp[j]` stores the minimum last segment sum for an array of length `j`.
        dp[j] = Math.min(dp[j], newSegmentSum);

        // Update the overall maximum length found.
        currentMaxLen = Math.max(currentMaxLen, j);
    }

    return currentMaxLen;
};