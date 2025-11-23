var pathsWithSumDivisibleByK = function(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    const MOD = 10 ** 9 + 7;

    const dp = Array(m).fill(0).map(() =>
        Array(n).fill(0).map(() =>
            Array(k).fill(0)
        )
    );

    dp[0][0][grid[0][0] % k] = 1;

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (r === 0 && c === 0) {
                continue;
            }

            const currentValModK = grid[r][c] % k;

            if (r > 0) {
                for (let prevRem = 0; prevRem < k; prevRem++) {
                    if (dp[r - 1][c][prevRem] > 0) {
                        const newRem = (prevRem + currentValModK) % k;
                        dp[r][c][newRem] = (dp[r][c][newRem] + dp[r - 1][c][prevRem]) % MOD;
                    }
                }
            }

            if (c > 0) {
                for (let prevRem = 0; prevRem < k; prevRem++) {
                    if (dp[r][c - 1][prevRem] > 0) {
                        const newRem = (prevRem + currentValModK) % k;
                        dp[r][c][newRem] = (dp[r][c][newRem] + dp[r][c - 1][prevRem]) % MOD;
                    }
                }
            }
        }
    }

    return dp[m - 1][n - 1][0];
};