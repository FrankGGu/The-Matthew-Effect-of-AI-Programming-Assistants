var minCost = function(houses, cost, m, n, target) {
    const INF = 1e9;
    let dp = new Array(m + 1).fill().map(() => 
        new Array(target + 1).fill().map(() => 
            new Array(n + 1).fill(INF)
        )
    );

    if (houses[0] === 0) {
        for (let color = 1; color <= n; color++) {
            dp[1][1][color] = cost[0][color - 1];
        }
    } else {
        dp[1][1][houses[0]] = 0;
    }

    for (let i = 2; i <= m; i++) {
        for (let k = 1; k <= Math.min(target, i); k++) {
            if (houses[i - 1] === 0) {
                for (let currColor = 1; currColor <= n; currColor++) {
                    for (let prevColor = 1; prevColor <= n; prevColor++) {
                        if (prevColor === currColor) {
                            dp[i][k][currColor] = Math.min(dp[i][k][currColor], dp[i - 1][k][prevColor] + cost[i - 1][currColor - 1]);
                        } else {
                            dp[i][k][currColor] = Math.min(dp[i][k][currColor], dp[i - 1][k - 1][prevColor] + cost[i - 1][currColor - 1]);
                        }
                    }
                }
            } else {
                const currColor = houses[i - 1];
                for (let prevColor = 1; prevColor <= n; prevColor++) {
                    if (prevColor === currColor) {
                        dp[i][k][currColor] = Math.min(dp[i][k][currColor], dp[i - 1][k][prevColor]);
                    } else {
                        dp[i][k][currColor] = Math.min(dp[i][k][currColor], dp[i - 1][k - 1][prevColor]);
                    }
                }
            }
        }
    }

    let res = INF;
    for (let color = 1; color <= n; color++) {
        res = Math.min(res, dp[m][target][color]);
    }

    return res === INF ? -1 : res;
};