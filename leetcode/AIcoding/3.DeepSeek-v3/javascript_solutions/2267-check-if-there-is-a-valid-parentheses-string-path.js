var isValid = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    if ((m + n - 1) % 2 !== 0) return false;

    const maxK = Math.min(m + n - 1, 100);
    const dp = Array.from({ length: m }, () => 
        Array.from({ length: n }, () => new Array(maxK + 1).fill(false))
    );

    if (grid[0][0] === '(') {
        dp[0][0][1] = true;
    } else {
        return false;
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i === 0 && j === 0) continue;
            for (let k = 0; k <= maxK; k++) {
                let current = false;
                if (i > 0 && dp[i-1][j][k]) {
                    current = true;
                }
                if (j > 0 && dp[i][j-1][k]) {
                    current = true;
                }
                if (current) {
                    const newK = k + (grid[i][j] === '(' ? 1 : -1);
                    if (newK >= 0 && newK <= maxK) {
                        dp[i][j][newK] = true;
                    }
                }
            }
        }
    }

    return dp[m-1][n-1][0];
};