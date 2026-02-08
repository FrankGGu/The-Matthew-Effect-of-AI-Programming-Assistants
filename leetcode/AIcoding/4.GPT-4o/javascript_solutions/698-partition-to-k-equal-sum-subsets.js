var canPartitionKSubsets = function(nums, k) {
    const total = nums.reduce((a, b) => a + b, 0);
    if (total % k !== 0) return false;
    const target = total / k;
    const n = nums.length;
    const dp = new Array(1 << n).fill(0);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) === 0) {
                const newMask = mask | (1 << i);
                dp[newMask] = (dp[mask] + nums[i]) % target;
            }
        }
    }

    return dp[(1 << n) - 1] === 0;
};