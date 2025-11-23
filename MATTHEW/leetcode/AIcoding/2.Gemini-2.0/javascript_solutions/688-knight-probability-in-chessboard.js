var knightProbability = function(n, k, row, column) {
    const moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]];
    let dp = Array(k + 1).fill(null).map(() => Array(n).fill(null).map(() => Array(n).fill(0)));
    dp[0][row][column] = 1;

    for (let step = 1; step <= k; step++) {
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                for (const [dx, dy] of moves) {
                    const prevX = i - dx;
                    const prevY = j - dy;
                    if (prevX >= 0 && prevX < n && prevY >= 0 && prevY < n) {
                        dp[step][i][j] += dp[step - 1][prevX][prevY] / 8;
                    }
                }
            }
        }
    }

    let totalProbability = 0;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            totalProbability += dp[k][i][j];
        }
    }

    return totalProbability;
};