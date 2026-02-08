var numberOfPaths = function(grid, k) {
    const MOD = 1e9 + 7;
    const m = grid.length;
    const n = grid[0].length;
    const dp = Array.from({ length: m }, () => 
        Array.from({ length: n }, () => 
            new Array(k).fill(0)
        )
    );

    dp[0][0][grid[0][0] % k] = 1;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i === 0 && j === 0) continue;
            const val = grid[i][j];
            for (let rem = 0; rem < k; rem++) {
                const newRem = (rem - val % k + k) % k;
                let sum = 0;
                if (i > 0) sum += dp[i - 1][j][newRem];
                if (j > 0) sum += dp[i][j - 1][newRem];
                dp[i][j][rem] = sum % MOD;
            }
        }
    }

    return dp[m - 1][n - 1][0];
};