var minimumWhiteTiles = function(floor, numCarpets, carpetLen) {
    const n = floor.length;
    const m = numCarpets;

    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + (floor[i] === '1' ? 1 : 0);
    }

    const dp = Array(n + 1).fill(0).map(() => Array(m + 1).fill(0));

    for (let i = 0; i <= n; i++) {
        dp[i][0] = prefixSum[i];
    }

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= m; j++) {
            // Option 1: Don't use a carpet ending at floor[i-1]
            const option1 = dp[i - 1][j] + (floor[i - 1] === '1' ? 1 : 0);

            // Option 2: Use a carpet ending at floor[i-1]
            const prevIndexForCarpet = Math.max(0, i - carpetLen);
            const option2 = dp[prevIndexForCarpet][j - 1];

            dp[i][j] = Math.min(option1, option2);
        }
    }

    return dp[n][m];
};