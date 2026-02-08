var minCostII = function(costs, n, k) {
    if (n === 0) {
        return 0;
    }

    if (k === 1) {
        if (n === 1) {
            return costs[0][0];
        } else {
            return -1;
        }
    }

    let dp = Array(n).fill(null).map(() => Array(k).fill(0));

    for (let j = 0; j < k; j++) {
        dp[0][j] = costs[0][j];
    }

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < k; j++) {
            let minCost = Infinity;
            for (let l = 0; l < k; l++) {
                if (l !== j) {
                    minCost = Math.min(minCost, dp[i - 1][l]);
                }
            }
            dp[i][j] = minCost + costs[i][j];
        }
    }

    let minTotalCost = Infinity;
    for (let j = 0; j < k; j++) {
        minTotalCost = Math.min(minTotalCost, dp[n - 1][j]);
    }

    return minTotalCost;
};