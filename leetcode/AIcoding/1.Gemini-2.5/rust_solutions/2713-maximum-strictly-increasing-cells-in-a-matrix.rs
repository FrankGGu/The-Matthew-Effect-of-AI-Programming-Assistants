struct Solution;

impl Solution {
    pub fn max_increasing_cells(matrix: Vec<Vec<i32>>) -> i32 {
        let n = matrix.len();
        let m = matrix[0].len();

        let mut cells: Vec<(i32, usize, usize)> = Vec::with_capacity(n * m);
        for r in 0..n {
            for c in 0..m {
                cells.push((matrix[r][c], r, c));
            }
        }

        cells.sort_unstable_by_key(|k| k.0);

        let mut row_max: Vec<i32> = vec![0; n];
        let mut col_max: Vec<i32> = vec![0; m];
        let mut max_overall_len = 0;

        let mut i = 0;
        while i < cells.len() {
            let mut j = i;
            while j < cells.len() && cells[j].0 == cells[i].0 {
                j += 1;
            }

            // Process the current group of cells with the same value
            let mut temp_updates: Vec<(usize, usize, i32)> = Vec::with_capacity(j - i);

            for k in i..j {
                let (_val, r, c) = cells[k];
                let current_len = 1 + std::cmp::max(row_max[r], col_max[c]);
                temp_updates.push((r, c, current_len));
                max_overall_len = std::cmp::max(max_overall_len, current_len);
            }

            // Apply updates to row_max and col_max after processing all cells in the current group.
            // This ensures that updates from cells within the same value group do not affect
            // calculations for other cells in the same group.
            for (r, c, len) in temp_updates {
                row_max[r] = std::cmp::max(row_max[r], len);
                col_max[c] = std::cmp::max(col_max[c], len);
            }

            i = j;
        }

        max_overall_len
    }
}