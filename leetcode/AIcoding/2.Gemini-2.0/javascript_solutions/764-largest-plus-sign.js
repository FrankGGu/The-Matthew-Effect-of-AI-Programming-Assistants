var orderOfLargestPlusSign = function(n, mines) {
    const grid = Array(n).fill(null).map(() => Array(n).fill(1));

    for (const [row, col] of mines) {
        grid[row][col] = 0;
    }

    const dp = Array(n).fill(null).map(() => Array(n).fill(0));
    let maxOrder = 0;

    for (let i = 0; i < n; i++) {
        let left = 0;
        let up = 0;
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                left++;
            } else {
                left = 0;
            }

            if (grid[j][i] === 1) {
                up++;
            } else {
                up = 0;
            }
            dp[i][j] = left;
            dp[j][i] = Math.min(dp[j][i], up);
        }

        let right = 0;
        let down = 0;
        for (let j = n - 1; j >= 0; j--) {
            if (grid[i][j] === 1) {
                right++;
            } else {
                right = 0;
            }

            if (grid[j][i] === 1) {
                down++;
            } else {
                down = 0;
            }
            dp[i][j] = Math.min(dp[i][j], right);
            dp[j][i] = Math.min(dp[j][i], down);
            maxOrder = Math.max(maxOrder, dp[i][j]);
        }
    }
    return maxOrder;
};