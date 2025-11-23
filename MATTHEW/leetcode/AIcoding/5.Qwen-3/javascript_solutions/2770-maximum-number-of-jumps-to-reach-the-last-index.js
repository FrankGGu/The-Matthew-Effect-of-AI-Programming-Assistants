function maxJumps(nums) {
    const n = nums.length;
    const dp = new Array(n).fill(0);

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (Math.abs(nums[i] - nums[j]) >= 2 && dp[j] + 1 > dp[i]) {
                dp[i] = dp[j] + 1;
            }
        }
    }

    return dp[n - 1];
}