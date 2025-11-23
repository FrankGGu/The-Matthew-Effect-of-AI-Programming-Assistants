var minFallingPathSum = function(grid) {
    const n = grid.length;

    if (n === 1) {
        return grid[0][0];
    }

    // Initialize prev_dp with the first row of the grid
    let prev_dp = [...grid[0]];

    // Iterate through rows starting from the second row
    for (let r = 1; r < n; r++) {
        let min1 = Infinity; // Smallest value in prev_dp
        let idx1 = -1;       // Index of the smallest value
        let min2 = Infinity; // Second smallest value in prev_dp

        // Find the two smallest values and the index of the smallest in prev_dp
        for (let j = 0; j < n; j++) {
            if (prev_dp[j] < min1) {
                min2 = min1; // Current min1 becomes min2
                min1 = prev_dp[j];
                idx1 = j;
            } else if (prev_dp[j] < min2) {
                min2 = prev_dp[j];
            }
        }

        // Calculate the current row's dp values
        let curr_dp = new Array(n);
        for (let c = 0; c < n; c++) {
            // If the current column 'c' is the index of the smallest value from the previous row,
            // we must use the second smallest value (min2) to avoid choosing from the same column.
            if (c === idx1) {
                curr_dp[c] = grid[r][c] + min2;
            } else {
                // Otherwise, we can use the smallest value (min1) from the previous row.
                curr_dp[c] = grid[r][c] + min1;
            }
        }
        // Update prev_dp for the next iteration
        prev_dp = curr_dp;
    }

    // The minimum falling path sum will be the minimum value in the last row (prev_dp)
    let minSum = Infinity;
    for (let i = 0; i < n; i++) {
        minSum = Math.min(minSum, prev_dp[i]);
    }

    return minSum;
};