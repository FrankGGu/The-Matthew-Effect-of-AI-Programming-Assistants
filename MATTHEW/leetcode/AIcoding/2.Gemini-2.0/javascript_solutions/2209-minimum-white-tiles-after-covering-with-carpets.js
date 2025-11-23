var minimumWhiteTiles = function(floor, numCarpets, carpetLen) {
    const n = floor.length;
    const dp = Array(numCarpets + 1).fill(null).map(() => Array(n + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        dp[0][i] = dp[0][i - 1] + parseInt(floor[i - 1]);
    }

    for (let i = 1; i <= numCarpets; i++) {
        for (let j = 1; j <= n; j++) {
            dp[i][j] = Math.min(dp[i - 1][Math.max(0, j - carpetLen)], dp[i][j - 1] + parseInt(floor[j - 1]));
        }
    }

    return dp[numCarpets][n];
};