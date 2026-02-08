var goodSubsetofBinaryMatrix = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    // A subset of rows is "good" if for every column j, the sum of elements grid[i][j]
    // for all rows i in the subset is equal to 0.
    // Since grid[i][j] can only be 0 or 1, the sum for a column j can only be 0
    // if and only if every element grid[i][j] for all rows i in the subset is 0.
    // This implies that every row in a "good subset" must itself be an all-zeros row.

    // Therefore, we just need to find if there is any row that consists entirely of zeros.
    // If such a row exists, a subset containing just this single row is a good subset.
    // If no such row exists, then no good subset can be formed.

    for (let i = 0; i < m; i++) {
        let isAllZeros = true;
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                isAllZeros = false;
                break; // Found a 1, this row is not all zeros
            }
        }
        if (isAllZeros) {
            // Found an all-zeros row, return its index
            return [i];
        }
    }

    // If no all-zeros row was found after checking all rows,
    // then no good subset can be formed.
    return [];
};