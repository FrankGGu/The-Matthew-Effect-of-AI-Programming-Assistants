var minimumAbsoluteDifference = function(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    // Assuming values in grid are within a small, positive range (e.g., 1 to 100).
    // This allows the use of a frequency array for efficient updates.
    // If values can be larger, a Map and sorting keys, or a custom SortedList/TreeSet implementation would be needed.
    const MAX_VALUE = 100; 

    let overallMinDiff = Infinity;

    // Helper function to calculate the minimum absolute difference
    // among elements present in the `counts` array.
    // Returns 0 if duplicate values exist, Infinity if fewer than two distinct values,
    // otherwise the minimum difference between any two distinct values.
    function getMinDiffFromCounts(counts) {
        let minDiff = Infinity;
        let lastSeenValue = -1; // Use -1 to indicate no value seen yet (since values are >= 1)
        let distinctCount = 0;

        for (let val = 1; val <= MAX_VALUE; val++) {
            if (counts[val] > 0) {
                distinctCount++;
                // If there are duplicate values of 'val', the minimum difference is 0.
                if (counts[val] > 1) {
                    return 0; 
                }
                if (lastSeenValue !== -1) {
                    minDiff = Math.min(minDiff, val - lastSeenValue);
                }
                lastSeenValue = val;
            }
        }
        // If there are fewer than two distinct elements and no duplicates,
        // no difference can be calculated, so return Infinity.
        if (distinctCount < 2) {
            return Infinity;
        }
        return minDiff;
    }

    // Iterate through all possible top-left corners (r, c) for the k x k submatrices
    for (let r = 0; r <= m - k; r++) {
        // `currentWindowCounts` will store frequencies for the current k x k submatrix.
        // Initialize for the first submatrix in this row `r` (top-left at `(r, 0)`).
        let currentWindowCounts = new Array(MAX_VALUE + 1).fill(0);
        for (let i = r; i < r + k; i++) {
            for (let j = 0; j < k; j++) {
                currentWindowCounts[grid[i][j]]++;
            }
        }
        overallMinDiff = Math.min(overallMinDiff, getMinDiffFromCounts(currentWindowCounts));

        // Slide horizontally for the rest of the submatrices in this row `r`.
        // `c` represents the starting column of the submatrix.
        for (let c = 1; c <= n - k; c++) {
            // Remove the leftmost column (c-1) of the previous submatrix
            for (let i = r; i < r + k; i++) {
                currentWindowCounts[grid[i][c - 1]]--;
            }
            // Add the rightmost column (c + k - 1) for the new submatrix
            for (let i = r; i < r + k; i++) {
                currentWindowCounts[grid[i][c + k - 1]]++;
            }
            overallMinDiff = Math.min(overallMinDiff, getMinDiffFromCounts(currentWindowCounts));
        }
    }

    return overallMinDiff;
};