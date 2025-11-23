struct Solution;

impl Solution {
    pub fn max_value_sum(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();

        // Heuristic limit for the number of top rows to consider for each column.
        // This value is chosen to balance between correctness and performance.
        // A value of 8 allows for C(m, 3) * 8^3 operations, which is roughly 8 * 10^7,
        // fitting within typical time limits for N, M up to 100.
        let k_limit = 8; 

        // Precompute top K values for each column.
        // top_rows_for_col[j] stores a list of (value, row_idx) for column j,
        // sorted in descending order by value.
        let mut top_rows_for_col: Vec<Vec<(i32, usize)>> = vec![Vec::new(); m];

        for j in 0..m {
            for i in 0..n {
                top_rows_for_col[j].push((grid[i][j], i));
            }
            // Sort by value in descending order.
            top_rows_for_col[j].sort_unstable_by(|a, b| b.0.cmp(&a.0));
            // Keep only the top k_limit elements. If n < k_limit, it will naturally have fewer.
            top_rows_for_col[j].truncate(k_limit);
        }

        let mut max_total_sum = i32::MIN;

        // Iterate through all combinations of three distinct column indices (c1_idx, c2_idx, c3_idx).
        // C(m, 3) combinations.
        for c1_idx in 0..m {
            for c2_idx in (c1_idx + 1)..m {
                for c3_idx in (c2_idx + 1)..m {
                    // For these three distinct columns, we need to pick three distinct rows r1, r2, r3
                    // to maximize grid[r1][c1_idx] + grid[r2][c2_idx] + grid[r3][c3_idx].

                    let col1_candidates = &top_rows_for_col[c1_idx];
                    let col2_candidates = &top_rows_for_col[c2_idx];
                    let col3_candidates = &top_rows_for_col[c3_idx];

                    // Iterate through all combinations of rows from the top K candidates for each column.
                    // This is K * K * K iterations in the worst case for each column combination.
                    for &(val1, r1_idx) in col1_candidates.iter() {
                        for &(val2, r2_idx) in col2_candidates.iter() {
                            // The rows for the first two rooks must be distinct.
                            if r1_idx == r2_idx {
                                continue;
                            }
                            for &(val3, r3_idx) in col3_candidates.iter() {
                                // The row for the third rook must be distinct from the first two.
                                if r3_idx == r1_idx || r3_idx == r2_idx {
                                    continue;
                                }

                                let current_sum = val1 + val2 + val3;
                                if current_sum > max_total_sum {
                                    max_total_sum = current_sum;
                                }
                            }
                        }
                    }
                }
            }
        }

        max_total_sum
    }
}