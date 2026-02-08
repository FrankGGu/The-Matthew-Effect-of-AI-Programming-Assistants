var maxSumKSubArrays = function(nums, k, m) {
    const n = nums.length;
    if (k * m > n) return 0;

    const dp = Array(k + 1).fill(null).map(() => Array(n + 1).fill(-Infinity));
    const preSum = [0];
    for (let i = 0; i < n; i++) {
        preSum[i + 1] = preSum[i] + nums[i];
    }

    for (let i = 0; i <= n; i++) {
        dp[0][i] = 0;
    }

    for (let i = 1; i <= k; i++) {
        for (let j = 1; j <= n; j++) {
            dp[i][j] = dp[i][j - 1];
            if (j >= m) {
                let sum = preSum[j] - preSum[j - m];
                dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - m] + sum);
                for(let l = j - m + 1; l < j; l++){
                    sum = preSum[j] - preSum[l];
                    dp[i][j] = Math.max(dp[i][j], dp[i-1][l] + sum)
                }
            }
        }
    }

    return dp[k][n];
};