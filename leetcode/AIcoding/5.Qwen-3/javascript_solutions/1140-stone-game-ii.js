function stoneGameII(piles) {
    const n = piles.length;
    const dp = new Array(n).fill(0).map(() => new Array(n + 1).fill(0));

    for (let i = n - 1; i >= 0; i--) {
        dp[i][n] = piles[i];
        for (let j = n - 1; j > i; j--) {
            let max = 0;
            for (let k = 1; k <= j - i; k++) {
                max = Math.max(max, dp[i + k][j] - dp[i][j]);
            }
            dp[i][j] = dp[i][j + 1] + max;
        }
    }

    return dp[0][1];
}