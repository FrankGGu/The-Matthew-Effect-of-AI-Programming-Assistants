var findTargetSumWays = function(nums, target) {
    let sum = nums.reduce((a, b) => a + b, 0);
    if (Math.abs(target) > sum || (sum + target) % 2 !== 0) return 0;

    let positiveSum = (sum + target) / 2;
    let dp = new Array(positiveSum + 1).fill(0);
    dp[0] = 1;

    for (let num of nums) {
        for (let j = positiveSum; j >= num; j--) {
            dp[j] += dp[j - num];
        }
    }

    return dp[positiveSum];
};