var countSpecialSubsequences = function(nums) {
    const MOD = 1e9 + 7;
    const n = nums.length;
    let dp = Array(n + 1).fill(0);
    let count0 = 0, count1 = 0, count2 = 0;

    dp[0] = 1;

    for (let i = 0; i < n; i++) {
        if (nums[i] === 0) {
            dp[i + 1] = (dp[i] * 2) % MOD;
        } else if (nums[i] === 1) {
            dp[i + 1] = (dp[i] + count0) % MOD;
            count0 = (count0 + dp[i]) % MOD;
        } else if (nums[i] === 2) {
            dp[i + 1] = (dp[i] + count1) % MOD;
            count1 = (count1 + dp[i]) % MOD;
        }
    }

    return (dp[n] - 1 + MOD) % MOD;
};