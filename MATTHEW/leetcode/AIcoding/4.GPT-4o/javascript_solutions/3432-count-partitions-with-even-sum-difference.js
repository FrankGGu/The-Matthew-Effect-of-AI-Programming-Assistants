var countPartitions = function(nums, k) {
    const totalSum = nums.reduce((a, b) => a + b, 0);
    if ((totalSum - k) % 2 !== 0 || totalSum < k) return 0;
    const target = (totalSum - k) / 2;
    const mod = 1e9 + 7;
    const dp = new Array(target + 1).fill(0);
    dp[0] = 1;

    for (const num of nums) {
        for (let j = target; j >= num; j--) {
            dp[j] = (dp[j] + dp[j - num]) % mod;
        }
    }

    return dp[target];
};