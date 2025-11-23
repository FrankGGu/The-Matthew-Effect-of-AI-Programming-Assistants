function countSubMultisetsWithBoundedSum(nums, maxSum) {
    const MOD = 10**9 + 7;
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }

    const keys = Object.keys(freq).map(Number);
    const dp = new Array(maxSum + 1).fill(0);
    dp[0] = 1;

    for (const num of keys) {
        const count = freq[num];
        for (let s = maxSum; s >= num; s--) {
            for (let k = 1; k <= count && s - k * num >= 0; k++) {
                dp[s] = (dp[s] + dp[s - k * num]) % MOD;
            }
        }
    }

    return dp[maxSum];
}