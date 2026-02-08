var minDistance = function(houses, k) {
    houses.sort((a, b) => a - b);
    const n = houses.length;
    const cost = Array(n).fill(null).map(() => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            let median = houses[Math.floor((i + j) / 2)];
            for (let l = i; l <= j; l++) {
                cost[i][j] += Math.abs(houses[l] - median);
            }
        }
    }

    const dp = Array(n).fill(null).map(() => Array(k + 1).fill(Infinity));

    for (let i = 0; i < n; i++) {
        dp[i][1] = cost[0][i];
    }

    for (let j = 2; j <= k; j++) {
        for (let i = j - 1; i < n; i++) {
            for (let l = j - 2; l < i; l++) {
                dp[i][j] = Math.min(dp[i][j], dp[l][j - 1] + cost[l + 1][i]);
            }
        }
    }

    return dp[n - 1][k];
};