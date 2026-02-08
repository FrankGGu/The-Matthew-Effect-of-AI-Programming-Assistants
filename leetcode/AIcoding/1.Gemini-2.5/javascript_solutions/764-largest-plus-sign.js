var orderOfLargestPlusSign = function(n, mines) {
    const dp = Array(n).fill(0).map(() => Array(n).fill(n));

    for (const [r, c] of mines) {
        dp[r][c] = 0;
    }

    // Pass 1: Calculate left and up arm lengths
    // For each cell (r, c), dp[r][c] will be updated with the minimum of its current value
    // (which is n initially, or 0 if it's a mine) and the calculated arm length.

    // Left arm lengths
    for (let r = 0; r < n; r++) {
        let count = 0;
        for (let c = 0; c < n; c++) {
            if (dp[r][c] === 0) { 
                count = 0;
            } else {
                count++;
            }
            dp[r][c] = Math.min(dp[r][c], count);
        }
    }

    // Up arm lengths
    for (let c = 0; c < n; c++) {
        let count = 0;
        for (let r = 0; r < n; r++) {
            if (dp[r][c] === 0) { 
                count = 0;
            } else {
                count++;
            }
            dp[r][c] = Math.min(dp[r][c], count);
        }
    }

    // Pass 2: Calculate right and down arm lengths

    // Right arm lengths
    for (let r = n - 1; r >= 0; r--) {
        let count = 0;
        for (let c = n - 1; c >= 0; c--) {
            if (dp[r][c] === 0) { 
                count = 0;
            } else {
                count++;
            }
            dp[r][c] = Math.min(dp[r][c], count);
        }
    }

    // Down arm lengths
    for (let c = n - 1; c >= 0; c--) {
        let count = 0;
        for (let r = n - 1; r >= 0; r--) {
            if (dp[r][c] === 0) { 
                count = 0;
            } else {
                count++;
            }
            dp[r][c] = Math.min(dp[r][c], count);
        }
    }

    // Find the maximum order among all cells
    let maxOrder = 0;
    for (let r = 0; r < n; r++) {
        for (let c = 0; c < n; c++) {
            maxOrder = Math.max(maxOrder, dp[r][c]);
        }
    }

    return maxOrder;
};