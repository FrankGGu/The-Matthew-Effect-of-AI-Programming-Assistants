var countPartitions = function(nums, k) {
    const n = nums.length;
    const sum = nums.reduce((a, b) => a + b, 0);

    if (sum < 2 * k) {
        return 0;
    }

    const MOD = 10**9 + 7;
    let dp = new Array(k).fill(0);
    dp[0] = 1;

    for (let num of nums) {
        for (let j = k - 1; j >= num; j--) {
            dp[j] = (dp[j] + dp[j - num]) % MOD;
        }
    }

    let lessThanK = 0;
    for (let i = 0; i < k; i++) {
        lessThanK = (lessThanK + dp[i]) % MOD;
    }

    let total = 1;
    for (let i = 0; i < n; i++) {
        total = (total * 2) % MOD;
    }

    let result = (total - 2 * lessThanK % MOD + MOD) % MOD;

    return result;
};