var knightProbability = function(n, k, row, column) {
    if (k === 0) {
        return 1;
    }

    const dr = [-2, -2, -1, -1, 1, 1, 2, 2];
    const dc = [-1, 1, -2, 2, -2, 2, -1, 1];

    let dp = Array(n).fill(0).map(() => Array(n).fill(0));

    dp[row][column] = 1;

    for (let moves = 1; moves <= k; moves++) {
        let nextDp = Array(n).fill(0).map(() => Array(n).fill(0));
        for (let r = 0; r < n; r++) {
            for (let c = 0; c < n; c++) {
                if (dp[r][c] > 0) {
                    for (let i = 0; i < 8; i++) {
                        const nextR = r + dr[i];
                        const nextC = c + dc[i];

                        if (nextR >= 0 && nextR < n && nextC >= 0 && nextC < n) {
                            nextDp[nextR][nextC] += dp[r][c] / 8;
                        }
                    }
                }
            }
        }
        dp = nextDp;
    }

    let totalProbability = 0;
    for (let r = 0; r < n; r++) {
        for (let c = 0; c < n; c++) {
            totalProbability += dp[r][c];
        }
    }

    return totalProbability;
};