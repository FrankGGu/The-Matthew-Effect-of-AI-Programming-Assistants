var maxValueOfCoins = function(piles, k) {
    const n = piles.length;
    const dp = Array(n + 1).fill(null).map(() => Array(k + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= k; j++) {
            dp[i][j] = dp[i - 1][j];
            let currentSum = 0;
            for (let x = 1; x <= Math.min(j, piles[i - 1].length); x++) {
                currentSum += piles[i - 1][x - 1];
                dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - x] + currentSum);
            }
        }
    }

    return dp[n][k];
};