var maximumStrength = function(nums, k) {
    const n = nums.length;
    const dp = Array.from({ length: k + 1 }, () => Array(n + 1).fill(-Infinity));
    dp[0].fill(0);

    for (let i = 1; i <= k; i++) {
        let maxPrev = -Infinity;
        let sign = (i % 2 === 1) ? 1 : -1;
        const multiplier = sign * (k - i + 1);

        for (let j = 1; j <= n; j++) {
            maxPrev = Math.max(maxPrev, dp[i - 1][j - 1]);
            dp[i][j] = Math.max(
                dp[i][j - 1] + nums[j - 1] * multiplier,
                maxPrev + nums[j - 1] * multiplier
            );
        }
    }

    return Math.max(...dp[k]);
};