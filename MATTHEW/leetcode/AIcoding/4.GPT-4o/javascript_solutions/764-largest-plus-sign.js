var orderOfLargestPlusSign = function(N, mines) {
    const grid = Array.from({ length: N }, () => Array(N).fill(1));
    for (const [r, c] of mines) {
        grid[r][c] = 0;
    }

    const dp = Array.from({ length: N }, () => Array(N).fill(0));
    let maxOrder = 0;

    for (let r = 0; r < N; r++) {
        for (let c = 0; c < N; c++) {
            if (grid[r][c] === 1) {
                dp[r][c] = Math.min(
                    (r > 0 ? dp[r - 1][c] : 0) + 1,
                    (c > 0 ? dp[r][c - 1] : 0) + 1
                );
                maxOrder = Math.max(maxOrder, dp[r][c]);
            }
        }
    }

    for (let r = N - 1; r >= 0; r--) {
        for (let c = N - 1; c >= 0; c--) {
            if (grid[r][c] === 1) {
                dp[r][c] = Math.min(
                    dp[r][c],
                    (r < N - 1 ? dp[r + 1][c] : 0) + 1,
                    (c < N - 1 ? dp[r][c + 1] : 0) + 1
                );
                maxOrder = Math.max(maxOrder, dp[r][c]);
            }
        }
    }

    return maxOrder;
};