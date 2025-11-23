var minCost = function(nums, k) {
    const n = nums.length;
    // dp[i] will store the minimum cost to split the prefix nums[0...i-1]
    // The length of the prefix is i.
    const dp = Array(n + 1).fill(Infinity);
    dp[0] = 0; // Base case: cost to split an empty prefix is 0

    // Iterate through all possible end points of the current segment
    // i represents the current length of the prefix being considered (nums[0...i-1])
    for (let i = 1; i <= n; i++) {
        let currentTrimmedCost = 0;
        // Use a Map for frequency counts, as numbers in nums can be large
        const freq = new Map(); 

        // Iterate backwards from i-1 to 0 to find all possible start points of the current segment
        // The current segment is nums[j...i-1]
        // j is the starting index of the last segment
        for (let j = i - 1; j >= 0; j--) {
            const num = nums[j];
            const count = (freq.get(num) || 0) + 1;
            freq.set(num, count);

            // If this number appears 2 or more times, it contributes to trimmed_cost.
            // Each time a number's count increases beyond 1 (i.e., from 1 to 2, 2 to 3, etc.),
            // it adds 1 to the trimmed_cost sum.
            if (count >= 2) {
                currentTrimmedCost += 1;
            }

            // Calculate cost for splitting at j: dp[j] + k + trimmed_cost(nums[j...i-1])
            // dp[j] is the minimum cost for the prefix nums[0...j-1]
            dp[i] = Math.min(dp[i], dp[j] + k + currentTrimmedCost);
        }
    }

    return dp[n];
};