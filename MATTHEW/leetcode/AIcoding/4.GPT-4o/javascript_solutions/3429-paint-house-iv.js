var minCost = function (houses, cost, m, n, target) {
    const dp = Array(m + 1).fill(0).map(() => Array(n + 1).fill(0).map(() => Array(target + 1).fill(Infinity)));
    dp[0][0][0] = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j <= target; j++) {
            for (let k = 1; k <= n; k++) {
                if (houses[i] === 0) {
                    for (let c = 1; c <= n; c++) {
                        let newJ = j + (c === k ? 0 : 1);
                        if (newJ <= target) {
                            dp[i + 1][c][newJ] = Math.min(dp[i + 1][c][newJ], dp[i][k][j] + cost[i][c - 1]);
                        }
                    }
                } else {
                    let newJ = j + (houses[i] === k ? 0 : 1);
                    if (newJ <= target) {
                        dp[i + 1][houses[i]][newJ] = Math.min(dp[i + 1][houses[i]][newJ], dp[i][k][j]);
                    }
                }
            }
        }
    }

    let result = Infinity;
    for (let k = 1; k <= n; k++) {
        result = Math.min(result, dp[m][k][target]);
    }

    return result === Infinity ? -1 : result;
};