var minSpaceWastedKResizing = function(nums, k) {
    const n = nums.length;
    const dp = Array(n + 1).fill(null).map(() => Array(k + 2).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= k + 1; j++) {
            for (let x = 1; x <= i; x++) {
                let maxVal = 0;
                let sum = 0;
                for (let l = i; l >= x; l--) {
                    maxVal = Math.max(maxVal, nums[l - 1]);
                    sum += nums[l - 1];
                }
                const wasted = maxVal * (i - x + 1) - sum;
                if (j > 0 && dp[x - 1][j - 1] !== Infinity) {
                    dp[i][j] = Math.min(dp[i][j], dp[x - 1][j - 1] + wasted);
                }
            }
        }
    }

    return dp[n][k + 1];
};