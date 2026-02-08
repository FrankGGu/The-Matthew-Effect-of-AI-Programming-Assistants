var matrixScore = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let totalScore = 0;

    // The most significant bit (leftmost column) for each row should always be 1
    // to maximize the score. If grid[i][0] is 0, we conceptually flip the entire row.
    // This means the contribution from the first column is always m * (1 << (n - 1)).
    totalScore += m * (1 << (n - 1));

    // For subsequent columns (from j = 1 to n-1):
    // We want to maximize the number of 1s in each column.
    // If a row 'i' had its first element grid[i][0] as 0, it means that row was conceptually flipped.
    // So, for any element grid[i][j] in that row, its value would be 1 - grid[i][j].
    // If grid[i][0] was 1, the row was not flipped, and grid[i][j] keeps its original value.
    for (let j = 1; j < n; j++) {
        let countOnes = 0;
        for (let i = 0; i < m; i++) {
            // Determine the effective value of grid[i][j] after potential row flips
            // (based on grid[i][0])
            let effectiveBit = grid[i][j];
            if (grid[i][0] === 0) {
                // If the first element of the row was 0, this row was conceptually flipped.
                // So, grid[i][j] also flips.
                effectiveBit = 1 - effectiveBit;
            }
            if (effectiveBit === 1) {
                countOnes++;
            }
        }

        // To maximize the score for this column, we choose to have either 'countOnes' 1s
        // or 'm - countOnes' 1s (if we flip the entire column).
        // We pick the larger count.
        const optimalOnes = Math.max(countOnes, m - countOnes);
        totalScore += optimalOnes * (1 << (n - 1 - j));
    }

    return totalScore;
};