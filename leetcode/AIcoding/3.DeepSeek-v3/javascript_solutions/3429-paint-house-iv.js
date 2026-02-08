var minCost = function(houses, cost, m, n, target) {
    const dp = new Array(m).fill().map(() => new Array(target + 1).fill().map(() => new Array(n + 1).fill(Infinity)));

    if (houses[0] === 0) {
        for (let color = 1; color <= n; color++) {
            dp[0][1][color] = cost[0][color - 1];
        }
    } else {
        dp[0][1][houses[0]] = 0;
    }

    for (let i = 1; i < m; i++) {
        for (let k = 1; k <= target; k++) {
            if (houses[i] !== 0) {
                const currentColor = houses[i];
                for (let prevColor = 1; prevColor <= n; prevColor++) {
                    if (prevColor === currentColor) {
                        dp[i][k][currentColor] = Math.min(dp[i][k][currentColor], dp[i - 1][k][prevColor]);
                    } else {
                        dp[i][k][currentColor] = Math.min(dp[i][k][currentColor], dp[i - 1][k - 1][prevColor]);
                    }
                }
            } else {
                for (let currentColor = 1; currentColor <= n; currentColor++) {
                    for (let prevColor = 1; prevColor <= n; prevColor++) {
                        if (prevColor === currentColor) {
                            dp[i][k][currentColor] = Math.min(dp[i][k][currentColor], dp[i - 1][k][prevColor] + cost[i][currentColor - 1]);
                        } else {
                            dp[i][k][currentColor] = Math.min(dp[i][k][currentColor], dp[i - 1][k - 1][prevColor] + cost[i][currentColor - 1]);
                        }
                    }
                }
            }
        }
    }

    let result = Infinity;
    for (let color = 1; color <= n; color++) {
        result = Math.min(result, dp[m - 1][target][color]);
    }

    return result === Infinity ? -1 : result;
};