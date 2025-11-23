var findPaths = function(m, n, maxMove, startRow, startColumn) {
    const MOD = 10**9 + 7;
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    let dp_current = new Array(m).fill(0).map(() => new Array(n).fill(0));

    for (let k = 1; k <= maxMove; k++) {
        let dp_next = new Array(m).fill(0).map(() => new Array(n).fill(0));
        for (let r = 0; r < m; r++) {
            for (let c = 0; c < n; c++) {
                for (const [dr, dc] of dirs) {
                    const nr = r + dr;
                    const nc = c + dc;

                    if (nr < 0 || nr >= m || nc < 0 || nc >= n) {
                        dp_next[r][c] = (dp_next[r][c] + 1) % MOD;
                    } else {
                        dp_next[r][c] = (dp_next[r][c] + dp_current[nr][nc]) % MOD;
                    }
                }
            }
        }
        dp_current = dp_next;
    }

    return dp_current[startRow][startColumn];
};