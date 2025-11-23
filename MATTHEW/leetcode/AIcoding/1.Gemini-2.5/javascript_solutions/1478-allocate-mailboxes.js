var minDistance = function(houses, k) {
    houses.sort((a, b) => a - b);
    const n = houses.length;

    const cost = Array(n).fill(0).map(() => Array(n).fill(0));
    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            const medianIdx = Math.floor((i + j) / 2);
            let currentCost = 0;
            for (let x = i; x <= j; x++) {
                currentCost += Math.abs(houses[x] - houses[medianIdx]);
            }
            cost[i][j] = currentCost;
        }
    }

    const dp = Array(n + 1).fill(0).map(() => Array(k + 1).fill(Infinity));

    dp[0][0] = 0;

    for (let k_val = 1; k_val <= k; k_val++) {
        for (let i = 1; i <= n; i++) {
            for (let j = 0; j < i; j++) {
                if (dp[j][k_val - 1] !== Infinity) {
                    dp[i][k_val] = Math.min(dp[i][k_val], dp[j][k_val - 1] + cost[j][i - 1]);
                }
            }
        }
    }

    return dp[n][k];
};