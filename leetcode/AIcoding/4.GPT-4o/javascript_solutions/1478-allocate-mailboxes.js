var minDistance = function(houses, m) {
    houses.sort((a, b) => a - b);
    const n = houses.length;
    const dp = Array.from({ length: n + 1 }, () => Array(m + 1).fill(Infinity));
    const cost = Array.from({ length: n + 1 }, () => Array(n + 1).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            const mid = houses[Math.floor((i + j) / 2)];
            for (let k = i; k <= j; k++) {
                cost[i][j] += Math.abs(houses[k] - mid);
            }
        }
    }

    dp[0][0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= Math.min(i, m); j++) {
            for (let k = 0; k < i; k++) {
                dp[i][j] = Math.min(dp[i][j], dp[k][j - 1] + cost[k][i - 1]);
            }
        }
    }

    return dp[n][m];
};