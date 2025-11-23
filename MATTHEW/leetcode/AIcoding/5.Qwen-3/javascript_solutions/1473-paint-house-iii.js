function minCost(houses, cost, m, n, k) {
    const INF = Math.pow(10, 9);
    const dp = new Array(m).fill(0).map(() => new Array(n).fill(0).map(() => new Array(k + 1).fill(INF)));

    for (let i = 0; i < n; i++) {
        dp[0][i][1] = cost[0][i];
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (houses[i][j] !== 0) {
                for (let l = 1; l <= k; l++) {
                    if (l === 1) {
                        dp[i][j][l] = 0;
                    } else {
                        for (let prev = 0; prev < n; prev++) {
                            if (prev !== j) {
                                dp[i][j][l] = Math.min(dp[i][j][l], dp[i][prev][l - 1]);
                            }
                        }
                    }
                }
            }
        }
    }

    for (let i = 1; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (houses[i][j] !== 0) {
                for (let l = 1; l <= k; l++) {
                    for (let prev = 0; prev < n; prev++) {
                        if (prev !== j) {
                            dp[i][j][l] = Math.min(dp[i][j][l], dp[i - 1][prev][l - 1]);
                        }
                    }
                }
            } else {
                for (let l = 1; l <= k; l++) {
                    for (let prev = 0; prev < n; prev++) {
                        if (prev !== j) {
                            dp[i][j][l] = Math.min(dp[i][j][l], dp[i - 1][prev][l - 1] + cost[i][j]);
                        }
                    }
                }
            }
        }
    }

    let result = INF;
    for (let j = 0; j < n; j++) {
        result = Math.min(result, dp[m - 1][j][k]);
    }

    return result === INF ? -1 : result;
}