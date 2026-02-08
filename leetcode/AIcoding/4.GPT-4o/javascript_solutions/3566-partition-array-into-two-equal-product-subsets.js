var canPartition = function(nums) {
    const totalProduct = nums.reduce((a, b) => a * b, 1);
    if (totalProduct % 2 !== 0) return false;

    const targetProduct = totalProduct / 2;
    const n = nums.length;
    const dp = new Array(targetProduct + 1).fill(false);
    dp[1] = true;

    for (let num of nums) {
        for (let j = targetProduct; j >= num; j--) {
            if (j % num === 0) {
                dp[j] = dp[j] || dp[j / num];
            }
        }
    }

    return dp[targetProduct];
};