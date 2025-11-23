function maxBalancedSubsequenceSum(nums, indices) {
    const n = nums.length;
    const pairs = [];
    for (let i = 0; i < n; i++) {
        pairs.push([indices[i], nums[i], i]);
    }
    pairs.sort((a, b) => a[0] - b[0]);

    const dp = new Array(n).fill(0);
    let maxSum = -Infinity;

    for (let i = 0; i < n; i++) {
        dp[i] = pairs[i][1];
        for (let j = 0; j < i; j++) {
            if (pairs[j][0] <= pairs[i][0] && pairs[j][2] < pairs[i][2]) {
                dp[i] = Math.max(dp[i], dp[j] + pairs[i][1]);
            }
        }
        maxSum = Math.max(maxSum, dp[i]);
    }

    return maxSum;
}