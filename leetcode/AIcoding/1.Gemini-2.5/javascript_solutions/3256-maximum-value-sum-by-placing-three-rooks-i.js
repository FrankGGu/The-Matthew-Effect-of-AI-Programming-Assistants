var maxValueSum = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const MIN_INF = -Infinity;

    // best_val_above[r][c] stores the maximum value grid[x][c] for any row x < r.
    // This array helps find the best rook to place above the current row 'r' in a specific column 'c'.
    // Initialized with MIN_INF. For r=0, all values will be MIN_INF as there are no rows above.
    // For r=1, best_val_above[1][c] will be grid[0][c].
    const best_val_above = Array(m).fill(0).map(() => Array(n).fill(MIN_INF));
    for (let r = 1; r < m; r++) {
        for (let c = 0; c < n; c++) {
            best_val_above[r][c] = Math.max(best_val_above[r-1][c], grid[r-1][c]);
        }
    }

    // best_val_below[r][c] stores the maximum value grid[x][c] for any row x > r.
    // This array helps find the best rook to place below the current row 'r' in a specific column 'c'.
    // Initialized with MIN_INF. For r=m-1, all values will be MIN_INF as there are no rows below.
    // For r=m-2, best_val_below[m-2][c] will be grid[m-1][c].
    const best_val_below = Array(m).fill(0).map(() => Array(n).fill(MIN_INF));
    for (let r = m - 2; r >= 0; r--) {
        for (let c = 0; c < n; c++) {
            best_val_below[r][c] = Math.max(best_val_below[r+1][c], grid[r+1][c]);
        }
    }

    let maxOverallSum = MIN_INF;

    // We iterate through all possible positions for the second (middle) rook (r2, c2).
    // For each (r2, c2), we then try to find the best first rook (r1, c1) and third rook (r3, c3).
    for (let r2 = 0; r2 < m; r2++) {
        for (let c2 = 0; c2 < n; c2++) {
            const val2 = grid[r2][c2];
            let max_sum_r1c1_r3c3 = MIN_INF;

            // The conditions for (r1, c1) and (r3, c3) are:
            // 1. r1 < r2 (first rook is above the second)
            // 2. r3 > r2 (third rook is below the second)
            // 3. c1 != c2 (first rook's column is different from second's)
            // 4. c3 != c2 (third rook's column is different from second's)
            // 5. c1 != c3 (first and third rooks' columns are different)

            // Iterate through all possible columns for the first rook (c1)
            for (let c1 = 0; c1 < n; c1++) {
                if (c1 === c2) { // c1 must be different from c2
                    continue;
                }
                const val_r1_c1 = best_val_above[r2][c1];
                if (val_r1_c1 === MIN_INF) { // No valid rook can be placed above r2 in column c1
                    continue;
                }

                // Iterate through all possible columns for the third rook (c3)
                for (let c3 = 0; c3 < n; c3++) {
                    if (c3 === c2 || c3 === c1) { // c3 must be different from c2 AND c1
                        continue;
                    }
                    const val_r3_c3 = best_val_below[r2][c3];
                    if (val_r3_c3 === MIN_INF) { // No valid rook can be placed below r2 in column c3
                        continue;
                    }
                    max_sum_r1c1_r3c3 = Math.max(max_sum_r1c1_r3c3, val_r1_c1 + val_r3_c3);
                }
            }

            // If a valid pair of (r1, c1) and (r3, c3) was found for the current (r2, c2)
            if (max_sum_r1c1_r3c3 !== MIN_INF) {
                maxOverallSum = Math.max(maxOverallSum, val2 + max_sum_r1c1_r3c3);
            }
        }
    }

    return maxOverallSum;
};