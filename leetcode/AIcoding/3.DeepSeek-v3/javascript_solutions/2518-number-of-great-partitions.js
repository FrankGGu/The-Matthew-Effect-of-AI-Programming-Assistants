var countPartitions = function(nums, k) {
    const MOD = 1e9 + 7;
    let totalSum = nums.reduce((sum, num) => sum + num, 0);
    if (totalSum < 2 * k) return 0;

    let dp = new Array(k).fill(0);
    dp[0] = 1;
    let res = 1;

    for (const num of nums) {
        res = (res * 2) % MOD;
        for (let j = k - 1; j >= num; j--) {
            dp[j] = (dp[j] + dp[j - num]) % MOD;
        }
    }

    let invalid = 0;
    for (let j = 0; j < k; j++) {
        invalid = (invalid + dp[j]) % MOD;
    }
    invalid = (invalid * 2) % MOD;

    return (res - invalid + MOD) % MOD;
};