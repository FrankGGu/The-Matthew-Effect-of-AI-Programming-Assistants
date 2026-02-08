var maxCoins = function(nums) {
    const n = nums.length;

    // Create a new array with dummy balloons at the ends
    // newNums[0] and newNums[n+1] are 1
    const newNums = new Array(n + 2);
    newNums[0] = 1;
    newNums[n + 1] = 1;
    for (let i = 0; i < n; i++) {
        newNums[i + 1] = nums[i];
    }

    // dp[i][j] represents the maximum coins obtained by bursting all balloons
    // strictly between newNums[i] and newNums[j].
    // newNums[i] and newNums[j] are considered as boundary balloons and are not burst within this subproblem.
    const dp = Array(n + 2).fill(0).map(() => Array(n + 2).fill(0));

    // Iterate over the length of the subproblem interval
    // 'len' is the number of balloons to burst in the original array, plus 2 for boundaries
    // So, len = j - i. We start with len = 2, meaning one balloon between i and j.
    for (let len = 2; len <= n + 1; len++) {
        // Iterate over the starting index 'i'
        // 'i' goes from 0 up to (n+1 - len)
        for (let i = 0; i <= n + 1 - len; i++) {
            // Calculate the ending index 'j'
            const j = i + len;
            // Iterate over all possible 'k' (the last balloon to burst in the current subproblem)
            // 'k' must be strictly between 'i' and 'j'
            for (let k = i + 1; k < j; k++) {
                // The coins obtained if newNums[k] is the last balloon to be burst in (i, j)
                // This includes:
                // 1. Coins from bursting balloons in the left subproblem (i, k)
                // 2. Coins from bursting balloons in the right subproblem (k, j)
                // 3. Coins from bursting newNums[k] itself, with newNums[i] and newNums[j] as its neighbors
                const currentCoins = dp[i][k] + newNums[i] * newNums[k] * newNums[j] + dp[k][j];
                dp[i][j] = Math.max(dp[i][j], currentCoins);
            }
        }
    }

    // The maximum coins for bursting all original balloons is dp[0][n+1],
    // which covers balloons from newNums[1] to newNums[n] with newNums[0] and newNums[n+1] as boundaries.
    return dp[0][n + 1];
};