var minCost = function(locations, costPerMile, travelTimePerMile) {
    locations.sort((a, b) => a - b);
    const n = locations.length;
    const dp = Array(n).fill(null).map(() => Array(n).fill(Infinity));

    for (let i = 0; i < n; i++) {
        dp[i][i] = 0;
    }

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            let j = i + len - 1;
            for (let k = i; k < j; k++) {
                dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k + 1][j] + (locations[j] - locations[i]) * costPerMile + Math.min(locations[k+1] - locations[i], locations[j] - locations[k]) * travelTimePerMile);
            }
        }
    }

    return dp[0][n - 1];
};