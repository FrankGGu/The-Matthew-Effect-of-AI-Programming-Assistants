var maxValueOfCoins = function(piles, k) {
    const n = piles.length;
    const dp = Array.from({ length: n + 1 }, () => Array(k + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= k; j++) {
            let currentSum = 0;
            dp[i][j] = dp[i - 1][j];
            for (let l = 1; l <= Math.min(j, piles[i - 1].length); l++) {
                currentSum += piles[i - 1][l - 1];
                dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - l] + currentSum);
            }
        }
    }

    return dp[n][k];
};