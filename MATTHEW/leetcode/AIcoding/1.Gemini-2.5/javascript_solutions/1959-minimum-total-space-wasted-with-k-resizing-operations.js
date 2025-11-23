var minSpaceWastedKResizing = function(nums, k) {
    const n = nums.length;

    // dp[i][j] will store the minimum total space wasted for the prefix nums[0...i-1]
    // using exactly j blocks (meaning j-1 resizing operations).
    // i ranges from 0 to n. j ranges from 0 to k+1.
    // k operations means at most k+1 blocks.
    const dp = Array(n + 1).fill(0).map(() => Array(k + 2).fill(Infinity));

    // Base case: 0 elements, 0 blocks, 0 waste.
    dp[0][0] = 0;

    // Iterate through the number of blocks (j)
    // j starts from 1 because we need at least one block for any elements.
    // The maximum number of blocks is k+1 (if k resizing operations are used).
    for (let j = 1; j <= k + 1; j++) {
        // Iterate through the end index (exclusive) of the current prefix (i)
        // i must be at least j because we need at least j elements to form j blocks.
        for (let i = j; i <= n; i++) {
            let currentMax = 0;
            let currentSum = 0;

            // Iterate through possible start indices (p) for the last block (nums[p...i-1])
            // p must be at least j-1, because nums[0...p-1] must be formable by j-1 blocks.
            for (let p = i - 1; p >= j - 1; p--) {
                currentMax = Math.max(currentMax, nums[p]);
                currentSum += nums[p];

                const currentBlockLength = i - p;
                const currentBlockWaste = currentBlockLength * currentMax - currentSum;

                // If dp[p][j-1] is reachable (not Infinity), update dp[i][j]
                if (dp[p][j - 1] !== Infinity) {
                    dp[i][j] = Math.min(dp[i][j], dp[p][j - 1] + currentBlockWaste);
                }
            }
        }
    }

    // The answer is the minimum waste for the entire array (nums[0...n-1])
    // using anywhere from 1 block (0 operations) to k+1 blocks (k operations).
    let minTotalWaste = Infinity;
    for (let j = 1; j <= k + 1; j++) {
        minTotalWaste = Math.min(minTotalWaste, dp[n][j]);
    }

    return minTotalWaste;
};