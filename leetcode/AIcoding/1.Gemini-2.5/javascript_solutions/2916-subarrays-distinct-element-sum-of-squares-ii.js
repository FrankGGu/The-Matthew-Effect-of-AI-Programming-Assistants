var sumOfSquares = function(nums) {
    const MOD = 10**9 + 7;
    const n = nums.length;

    let totalSumOfSquares = 0;
    let currentDpVal = 0; // Represents sum_{j=0 to i} (sum of squares of distinct elements in nums[j...i])
    const lastOccurrence = new Map(); // Stores the last seen index for each number

    for (let i = 0; i < n; i++) {
        const val = nums[i];
        const valSq = (val * val) % MOD;

        // Get the previous index of 'val'. If not seen before, consider it -1.
        const prevIdx = lastOccurrence.has(val) ? lastOccurrence.get(val) : -1;

        // The contribution of nums[i]^2 to currentDpVal.
        // For each subarray nums[j...i] where j > prevIdx, nums[i] is a new distinct element.
        // There are (i - prevIdx) such subarrays (j from prevIdx + 1 to i).
        const contributionFromVal = (valSq * (i - prevIdx)) % MOD;

        // Update currentDpVal using the recurrence:
        // dp[i] = dp[i-1] + (i - prevIdx) * nums[i]^2
        // where dp[i] is the sum of squares of distinct elements for all subarrays ending at i.
        currentDpVal = (currentDpVal + contributionFromVal) % MOD;

        // Update the last seen index for 'val'
        lastOccurrence.set(val, i);

        // Add currentDpVal to the total sum of squares
        totalSumOfSquares = (totalSumOfSquares + currentDpVal) % MOD;
    }

    return totalSumOfSquares;
};