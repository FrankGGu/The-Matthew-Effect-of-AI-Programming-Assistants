var stoneGameV = function(stoneValue) {
    const n = stoneValue.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + stoneValue[i];
    }

    const dp = Array(n).fill(null).map(() => Array(n).fill(0));

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            let j = i + len - 1;
            for (let k = i; k < j; k++) {
                let leftSum = prefixSum[k + 1] - prefixSum[i];
                let rightSum = prefixSum[j + 1] - prefixSum[k + 1];

                if (leftSum < rightSum) {
                    dp[i][j] = Math.max(dp[i][j], leftSum + dp[i][k]);
                } else if (leftSum > rightSum) {
                    dp[i][j] = Math.max(dp[i][j], rightSum + dp[k + 1][j]);
                } else {
                    dp[i][j] = Math.max(dp[i][j], leftSum + Math.max(dp[i][k], dp[k + 1][j]));
                }
            }
        }
    }

    return dp[0][n - 1];
};