var paintingPlan = function(grid) {
    const n = grid.length;
    const m = grid[0].length;

    const numGrid = Array(n).fill(0).map((_, r) => Array(m).fill(0).map((_, c) => (grid[r][c] === 'B' ? 1 : 0)));

    let operations = 0;

    for (let r = 0; r < n - 1; r++) {
        for (let c = 0; c < m - 1; c++) {
            if (numGrid[r][c] === 0) { // If current cell is white, we must flip the 2x2 block starting here
                operations++;
                numGrid[r][c] = 1 - numGrid[r][c];
                numGrid[r][c + 1] = 1 - numGrid[r][c + 1];
                numGrid[r + 1][c] = 1 - numGrid[r + 1][c];
                numGrid[r + 1][c + 1] = 1 - numGrid[r + 1][c + 1];
            }
        }
    }

    // After processing all possible 2x2 blocks from top-left,
    // check if the last row and last column are all black.
    // If not, it's impossible to make the entire grid black.

    // Check the last column
    for (let r = 0; r < n; r++) {
        if (numGrid[r][m - 1] === 0) {
            return -1;
        }
    }

    // Check the last row
    for (let c = 0; c < m; c++) {
        if (numGrid[n - 1][c] === 0) {
            return -1;
        }
    }

    return operations;
};