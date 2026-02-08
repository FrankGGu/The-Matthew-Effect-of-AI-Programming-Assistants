var cherryPickup = function(grid) {
    const n = grid.length;
    const dp = Array(n).fill(null).map(() => Array(n).fill(-Infinity));
    dp[0][0] = grid[0][0];

    for (let t = 1; t <= 2 * n - 2; t++) {
        const nextDp = Array(n).fill(null).map(() => Array(n).fill(-Infinity));
        for (let i = Math.max(0, t - (n - 1)); i <= Math.min(n - 1, t); i++) {
            for (let j = Math.max(0, t - (n - 1)); j <= Math.min(n - 1, t); j++) {
                if (grid[i][t - i] === -1 || grid[j][t - j] === -1) continue;

                let cherries = grid[i][t - i];
                if (i !== j) {
                    cherries += grid[j][t - j];
                }

                nextDp[i][j] = Math.max(
                    nextDp[i][j],
                    dp[i][j] + cherries,
                    (i > 0 ? dp[i - 1][j] + cherries : -Infinity),
                    (j > 0 ? dp[i][j - 1] + cherries : -Infinity),
                    (i > 0 && j > 0 ? dp[i - 1][j - 1] + cherries : -Infinity)
                );
            }
        }
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                dp[i][j] = nextDp[i][j];
            }
        }
    }

    return Math.max(0, dp[n - 1][n - 1]);
};