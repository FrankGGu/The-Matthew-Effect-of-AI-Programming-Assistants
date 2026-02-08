var maxPoints = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let dp = new Array(n).fill(0);

    for (let i = 0; i < m; i++) {
        let left = new Array(n).fill(0);
        let right = new Array(n).fill(0);

        left[0] = dp[0];
        for (let j = 1; j < n; j++) {
            left[j] = Math.max(left[j - 1] - 1, dp[j]);
        }

        right[n - 1] = dp[n - 1];
        for (let j = n - 2; j >= 0; j--) {
            right[j] = Math.max(right[j + 1] - 1, dp[j]);
        }

        for (let j = 0; j < n; j++) {
            dp[j] = Math.max(left[j], right[j]) + grid[i][j];
        }
    }

    let maxScore = 0;
    for (let j = 0; j < n; j++) {
        maxScore = Math.max(maxScore, dp[j]);
    }

    return maxScore;
};