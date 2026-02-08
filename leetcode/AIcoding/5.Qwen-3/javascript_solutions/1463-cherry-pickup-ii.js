function cherryPickup(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = Array.from({ length: m }, () => Array.from({ length: n }, () => Array(n).fill(-1)));

    dp[0][0][n - 1] = grid[0][0] + grid[0][n - 1];

    for (let i = 1; i < m; i++) {
        for (let j1 = 0; j1 < n; j1++) {
            for (let j2 = 0; j2 < n; j2++) {
                let maxCherries = -1;
                for (let dj1 = -1; dj1 <= 1; dj1++) {
                    for (let dj2 = -1; dj2 <= 1; dj2++) {
                        const prevJ1 = j1 + dj1;
                        const prevJ2 = j2 + dj2;
                        if (prevJ1 >= 0 && prevJ1 < n && prevJ2 >= 0 && prevJ2 < n) {
                            maxCherries = Math.max(maxCherries, dp[i - 1][prevJ1][prevJ2]);
                        }
                    }
                }
                if (maxCherries !== -1) {
                    dp[i][j1][j2] = maxCherries + grid[i][j1] + (j1 === j2 ? 0 : grid[i][j2]);
                }
            }
        }
    }

    let result = -1;
    for (let j1 = 0; j1 < n; j1++) {
        for (let j2 = 0; j2 < n; j2++) {
            result = Math.max(result, dp[m - 1][j1][j2]);
        }
    }
    return result;
}