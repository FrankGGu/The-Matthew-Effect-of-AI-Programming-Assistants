var minSpaceWasted = function(nums, k) {
    const n = nums.length;
    const max = Array.from({ length: n }, () => Array(n).fill(0));
    const sum = Array.from({ length: n }, () => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        let currentMax = nums[i];
        let currentSum = nums[i];
        max[i][i] = currentMax;
        sum[i][i] = currentSum;
        for (let j = i + 1; j < n; j++) {
            currentMax = Math.max(currentMax, nums[j]);
            currentSum += nums[j];
            max[i][j] = currentMax;
            sum[i][j] = currentSum;
        }
    }

    const dp = Array.from({ length: n }, () => Array(k + 1).fill(Infinity));

    for (let i = 0; i < n; i++) {
        dp[i][0] = max[0][i] * (i + 1) - sum[0][i];
    }

    for (let j = 1; j <= k; j++) {
        for (let i = 0; i < n; i++) {
            for (let m = 0; m < i; m++) {
                dp[i][j] = Math.min(dp[i][j], dp[m][j - 1] + max[m + 1][i] * (i - m) - sum[m + 1][i]);
            }
        }
    }

    return dp[n - 1][k];
};