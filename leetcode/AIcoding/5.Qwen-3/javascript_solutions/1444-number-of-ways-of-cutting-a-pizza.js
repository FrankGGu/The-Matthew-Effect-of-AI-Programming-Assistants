function ways(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const MOD = 1000000007;

    const dp = new Array(m).fill(0).map(() => new Array(n).fill(0).map(() => new Array(2).fill(0)));
    const prefix = new Array(m + 1).fill(0).map(() => new Array(n + 1).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            prefix[i + 1][j + 1] = grid[i][j] + prefix[i][j + 1] + prefix[i + 1][j] - prefix[i][j];
        }
    }

    function hasApple(x1, y1, x2, y2) {
        return prefix[x2 + 1][y2 + 1] - prefix[x1][y2 + 1] - prefix[x2 + 1][y1] + prefix[x1][y1] > 0;
    }

    for (let i = m - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            if (grid[i][j] === 1) {
                dp[i][j][0] = 1;
                dp[i][j][1] = 1;
            } else {
                dp[i][j][0] = 0;
                dp[i][j][1] = 0;
            }

            if (i < m - 1) {
                dp[i][j][0] = (dp[i][j][0] + dp[i + 1][j][0]) % MOD;
            }
            if (j < n - 1) {
                dp[i][j][0] = (dp[i][j][0] + dp[i][j + 1][0]) % MOD;
            }

            if (i < m - 1 && j < n - 1) {
                dp[i][j][1] = (dp[i][j][1] + dp[i + 1][j][1] + dp[i][j + 1][1] - dp[i + 1][j + 1][1]) % MOD;
            }
        }
    }

    let result = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (hasApple(i, j, m - 1, n - 1)) {
                result = (result + dp[i][j][1]) % MOD;
            }
        }
    }

    return result;
}