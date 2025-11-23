var findTargetSumWays = function(nums, target) {
    const sum = nums.reduce((a, b) => a + b, 0);
    if (sum < target || (sum + target) % 2 !== 0) return 0;
    const newTarget = (sum + target) / 2;
    const dp = new Array(newTarget + 1).fill(0);
    dp[0] = 1;

    for (const num of nums) {
        for (let j = newTarget; j >= num; j--) {
            dp[j] += dp[j - num];
        }
    }

    return dp[newTarget];
};