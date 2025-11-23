var countPartitions = function(nums, k) {
    const MOD = 1e9 + 7;
    const n = nums.length;
    let total = 0;
    for (const num of nums) {
        total += num;
    }
    if (total < 2 * k) {
        return 0;
    }
    let dp = new Array(k).fill(0);
    dp[0] = 1;
    for (const num of nums) {
        for (let j = k - 1; j >= num; --j) {
            dp[j] = (dp[j] + dp[j - num]) % MOD;
        }
    }
    let sum = 0;
    for (let i = 0; i < k; ++i) {
        sum = (sum + dp[i]) % MOD;
    }
    let totalPartitions = 1;
    for (let i = 0; i < n; ++i) {
        totalPartitions = (totalPartitions * 2) % MOD;
    }
    let result = (totalPartitions - 2 * sum + MOD) % MOD;
    return result;
};