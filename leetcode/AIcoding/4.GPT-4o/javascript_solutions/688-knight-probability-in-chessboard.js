var knightProbability = function(n, k, row, column) {
    const directions = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]];
    const dp = Array.from({ length: n }, () => Array.from({ length: n }, () => Array(k + 1).fill(0)));

    for (let j = 0; j < n; j++) {
        for (let i = 0; i < n; i++) {
            dp[i][j][0] = 1; 
        }
    }

    for (let step = 1; step <= k; step++) {
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                for (const [dx, dy] of directions) {
                    const ni = i + dx;
                    const nj = j + dy;
                    if (ni >= 0 && ni < n && nj >= 0 && nj < n) {
                        dp[i][j][step] += dp[ni][nj][step - 1] / 8;
                    }
                }
            }
        }
    }

    return dp[row][column][k];
};