var minCost = function(houses, cost, m, n, target) {
    const dp = Array(m + 1).fill(0).map(() => Array(n + 1).fill(0).map(() => Array(target + 1).fill(Infinity)));
    dp[0][0][0] = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j <= n; j++) {
            for (let k = 0; k <= target; k++) {
                if (houses[i] !== 0) {
                    const color = houses[i] - 1;
                    const newK = k - (i === 0 || (houses[i - 1] !== 0 && houses[i - 1] !== houses[i]) ? 1 : 0);
                    if (newK >= 0) {
                        dp[i + 1][color][newK] = Math.min(dp[i + 1][color][newK], dp[i][color][k]);
                    }
                } else {
                    for (let color = 0; color < n; color++) {
                        const newK = k - (i === 0 || (houses[i - 1] !== 0 && houses[i - 1] !== color + 1) ? 1 : 0);
                        if (newK >= 0) {
                            dp[i + 1][color][newK] = Math.min(dp[i + 1][color][newK], dp[i][color][k] + cost[i][color]);
                        }
                        for (let prevColor = 0; prevColor < n; prevColor++) {
                            dp[i + 1][color][k] = Math.min(dp[i + 1][color][k], dp[i][prevColor][k] + cost[i][color]);
                        }
                    }
                }
            }
        }
    }

    let res = Infinity;
    for (let color = 0; color < n; color++) {
        res = Math.min(res, dp[m][color][target]);
    }

    return res === Infinity ? -1 : res;
};