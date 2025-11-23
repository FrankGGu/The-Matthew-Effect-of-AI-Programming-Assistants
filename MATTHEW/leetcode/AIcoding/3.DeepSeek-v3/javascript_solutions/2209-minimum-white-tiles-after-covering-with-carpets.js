var minimumWhiteTiles = function(floor, numCarpets, carpetLen) {
    const n = floor.length;
    const dp = new Array(numCarpets + 1).fill().map(() => new Array(n + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        dp[0][i] = dp[0][i - 1] + (floor[i - 1] === '1' ? 1 : 0);
    }

    for (let k = 1; k <= numCarpets; k++) {
        for (let i = 1; i <= n; i++) {
            const skip = dp[k][i - 1] + (floor[i - 1] === '1' ? 1 : 0);
            const cover = i >= carpetLen ? dp[k - 1][i - carpetLen] : 0;
            dp[k][i] = Math.min(skip, cover);
        }
    }

    return dp[numCarpets][n];
};