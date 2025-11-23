var minCost = function(houses, cost, m, n, target) {
    const dp = Array(m).fill(null).map(() => Array(target + 1).fill(null).map(() => Array(n + 1).fill(Infinity)));

    for (let j = 1; j <= n; j++) {
        if (houses[0] === 0) {
            dp[0][1][j] = cost[0][j - 1];
        } else if (houses[0] === j) {
            dp[0][1][j] = 0;
        }
    }

    for (let i = 1; i < m; i++) {
        for (let k = 1; k <= target; k++) {
            for (let j = 1; j <= n; j++) {
                if (houses[i] !== 0 && houses[i] !== j) continue;

                let currentCost = houses[i] === 0 ? cost[i][j - 1] : 0;

                for (let prevColor = 1; prevColor <= n; prevColor++) {
                    if (prevColor === j) {
                        dp[i][k][j] = Math.min(dp[i][k][j], dp[i - 1][k][prevColor] + currentCost);
                    } else {
                        if (k > 1) {
                            dp[i][k][j] = Math.min(dp[i][k][j], dp[i - 1][k - 1][prevColor] + currentCost);
                        }
                    }
                }
            }
        }
    }

    let result = Infinity;
    for (let j = 1; j <= n; j++) {
        result = Math.min(result, dp[m - 1][target][j]);
    }

    return result === Infinity ? -1 : result;
};