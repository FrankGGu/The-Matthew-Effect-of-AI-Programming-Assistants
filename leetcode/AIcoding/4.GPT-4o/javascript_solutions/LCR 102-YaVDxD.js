var findTargetSumWays = function(nums, target) {
    const totalSum = nums.reduce((a, b) => a + b, 0);
    if (target > totalSum || (target + totalSum) % 2 !== 0) return 0;
    const newTarget = (target + totalSum) / 2;
    const dp = new Array(newTarget + 1).fill(0);
    dp[0] = 1;

    for (let num of nums) {
        for (let j = newTarget; j >= num; j--) {
            dp[j] += dp[j - num];
        }
    }

    return dp[newTarget];
};