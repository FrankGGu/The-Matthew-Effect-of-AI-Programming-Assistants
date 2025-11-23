var minimumOperations = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = new Array(n).fill().map(() => new Array(10).fill(Infinity));

    for (let k = 0; k < 10; k++) {
        let cnt = 0;
        for (let i = 0; i < m; i++) {
            if (grid[i][0] !== k) cnt++;
        }
        dp[0][k] = cnt;
    }

    for (let j = 1; j < n; j++) {
        for (let k = 0; k < 10; k++) {
            let cnt = 0;
            for (let i = 0; i < m; i++) {
                if (grid[i][j] !== k) cnt++;
            }
            let minPrev = Infinity;
            for (let l = 0; l < 10; l++) {
                if (l !== k) {
                    minPrev = Math.min(minPrev, dp[j-1][l]);
                }
            }
            dp[j][k] = minPrev + cnt;
        }
    }

    return Math.min(...dp[n-1]);
};