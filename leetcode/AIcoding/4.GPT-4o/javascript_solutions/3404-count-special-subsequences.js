var countSpecialSubsequences = function(nums) {
    const MOD = 1e9 + 7;
    const n = nums.length;
    let dp = Array(n + 1).fill(0);
    let count = Array(3).fill(0);

    dp[0] = 1; // the empty subsequence

    for (let i = 0; i < n; i++) {
        if (nums[i] === 0) {
            dp[i + 1] = (dp[i] * 2) % MOD;
        } else if (nums[i] === 1) {
            dp[i + 1] = (dp[i] + count[0]) % MOD;
        } else if (nums[i] === 2) {
            dp[i + 1] = (dp[i] + count[1]) % MOD;
        }
        count[nums[i]] = (count[nums[i]] + dp[i]) % MOD;
    }

    return (dp[n] - 1 + MOD) % MOD; // subtract the empty subsequence
};