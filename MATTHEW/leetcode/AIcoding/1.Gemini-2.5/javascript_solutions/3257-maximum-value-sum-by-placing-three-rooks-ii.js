var maxValueSum = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    let maxSum = -Infinity;

    // Precompute top 2 values for each row, excluding a specific column.
    // max1_val_excl_col[r][c_excl]: max value in row r, excluding column c_excl.
    // max1_idx_excl_col[r][c_excl]: column index for max1_val_excl_col.
    // max2_val_excl_col[r][c_excl]: second max value in row r, excluding column c_excl.
    // max2_idx_excl_col[r][c_excl]: column index for max2_val_excl_col.
    const max1_val_excl_col = Array(m).fill(0).map(() => Array(n).fill(-Infinity));
    const max1_idx_excl_col = Array(m).fill(0).map(() => Array(n).fill(-1));
    const max2_val_excl_col = Array(m).fill(0).map(() => Array(n).fill(-Infinity));
    const max2_idx_excl_col = Array(m).fill(0).map(() => Array(n).fill(-1));

    for (let r = 0; r < m; r++) {
        const row_vals = grid[r];
        const prefix_data = Array(n).fill(0).map(() => ({ val1: -Infinity, idx1: -1, val2: -Infinity, idx2: -1 }));
        const suffix_data = Array(n).fill(0).map(() => ({ val1: -Infinity, idx1: -1, val2: -Infinity, idx2: -1 }));

        // Prefix scan to find top 2 values and their indices up to current column
        for (let c = 0; c < n; c++) {
            if (c > 0) {
                prefix_data[c].val1 = prefix_data[c-1].val1;
                prefix_data[c].idx1 = prefix_data[c-1].idx1;
                prefix_data[c].val2 = prefix_data[c-1].val2;
                prefix_data[c].idx2 = prefix_data[c-1].idx2;
            }
            if (row_vals[c] > prefix_data[c].val1) {
                prefix_data[c].val2 = prefix_data[c].val1;
                prefix_data[c].idx2 = prefix_data[c].idx1;
                prefix_data[c].val1 = row_vals[c];
                prefix_data[c].idx1 = c;
            } else if (row_vals[c] > prefix_data[c].val2 && c !== prefix_data[c].idx1) {
                prefix_data[c].val2 = row_vals[c];
                prefix_data[c].idx2 = c;
            }
        }

        // Suffix scan to find top 2 values and their indices from current column to end
        for (let c = n - 1; c >= 0; c--) {
            if (c < n - 1) {
                suffix_data[c].val1 = suffix_data[c+1].val1;
                suffix_data[c].idx1 = suffix_data[c+1].idx1;
                suffix_data[c].val2 = suffix_data[c+1].val2;
                suffix_data[c].idx2 = suffix_data[c+1].idx2;
            }
            if (row_vals[c] > suffix_data[c].val1) {
                suffix_data[c].val2 = suffix_data[c].val1;
                suffix_data[c].idx2 = suffix_data[c].idx1;
                suffix_data[c].val1 = row_vals[c];
                suffix_data[c].idx1 = c;
            } else if (row_vals[c] > suffix_data[c].val2 && c !== suffix_data[c].idx1) {
                suffix_data[c].val2 = row_vals[c];
                suffix_data[c].idx2 = c;
            }
        }

        // Combine prefix and suffix to get max1/max2 excluding a specific column (c_excl)
        for (let c_excl = 0; c_excl < n; c_excl++) {
            let current_max1 = -Infinity, current_idx1 = -1;
            let current_max2 = -Infinity, current_idx2 = -1;

            const update_top_two = (val, idx) => {
                if (idx === -1) return;
                if (val > current_max1) {
                    current_max2 = current_max1;
                    current_idx2 = current_idx1;
                    current_max1 = val;
                    current_idx1 = idx;
                } else if (val > current_max2 && idx !== current_idx1) {
                    current_max2 = val;
                    current_idx2 = idx;
                }
            };

            if (c_excl > 0) {
                update_top_two(prefix_data[c_excl-1].val1, prefix_data[c_excl-1].idx1);
                update_top_two(prefix_data[c_excl-1].val2, prefix_data[c_excl-1].idx2);
            }
            if (c_excl < n-1) {
                update_top_two(suffix_data[c_excl+1].val1, suffix_data[c_excl+1].idx1);
                update_top_two(suffix_data[c_excl+1].val2, suffix_data[c_excl+1].idx2);
            }

            max1_val_excl_col[r][c_excl] = current_max1;
            max1_idx_excl_col[r][c_excl] = current_idx1;
            max2_val_excl_col[r][c_excl] = current_max2;
            max2_idx_excl_col[r][c_excl] = current_idx2;
        }
    }

    // Iterate through all distinct combinations of three rows (r1, r2, r3)
    for (let r1 = 0; r1 < m; r1++) {
        for (let r2 = 0; r2 < m; r2++) {
            if (r1 === r2) continue;
            for (let r3 = 0; r3 < m; r3++) {
                if (r3 === r1 || r3 === r2) continue;

                // For fixed distinct rows r1, r2, r3, find distinct columns c1, c2, c3
                // to maximize grid[r1][c1] + grid[r2][c2] + grid[r3][c3].

                let currentMaxForRows = -Infinity;

                // Iterate through all possible columns for the first rook (c1)
                for (let c1 = 0; c1 < n; c1++) {
                    const val_r1_c1 = grid[r1][c1];

                    // Find c2, c3 distinct, c2, c3 != c1, to maximize grid[r2][c2] + grid[r3][c3]

                    const candidates_for_c2_c3_sum = [];

                    // Get best value for r2 (excluding c1)
                    const val_r2_best1 = max1_val_excl_col[r2][c1];
                    const idx_r2_best1 = max1_idx_excl_col[r2][c1];

                    // Get best value for r3 (excluding c1)
                    const val_r3_best1 = max1_val_excl_col[r3][c1];
                    const idx_r3_best1 = max1_idx_excl_col[r3][c1];

                    // Case 1: Best choices for r2 and r3 use different columns
                    if (idx_r2_best1 !== -1 && idx_r3_best1 !== -1 && idx_r2_best1 !== idx_r3_best1) {
                        candidates_for_c2_c3_sum.push(val_r2_best1 + val_r3_best1);
                    } else if (idx_r2_best1 !== -1 && idx_r3_best1 !== -1) { // Best choices for r2 and r3 use the same column
                        // Option 1.1: Use best for r2, second best for r3 (if distinct)
                        const val_r3_best2 = max2_val_excl_col[r3][c1];
                        const idx_r3_best2 = max2_idx_excl_col[r3][c1];
                        if (idx_r3_best2 !== -1 && idx_r3_best2 !== idx_r2_best1) {
                            candidates_for_c2_c3_sum.push(val_r2_best1 + val_r3_best2);
                        }
                        // Option 1.2: Use second best for r2, best for r3 (if distinct)
                        const val_r2_best2 = max2_val_excl_col[r2][c1];
                        const idx_r2_best2 = max2_idx_excl_col[r2][c1];
                        if (idx_r2_best2 !== -1 && idx_r2_best2 !== idx_r3_best1) {
                            candidates_for_c2_c3_sum.push(val_r2_best2 + val_r3_best1);
                        }
                    }

                    if (candidates_for_c2_c3_sum.length > 0) {
                        currentMaxForRows = Math.max(currentMaxForRows, val_r1_c1 + Math.max(...candidates_for_c2_c3_sum));
                    }
                }
                if (currentMaxForRows !== -Infinity) {
                    maxSum = Math.max(maxSum, currentMaxForRows);
                }
            }
        }
    }

    return maxSum;
};