impl Solution {
    pub fn maximum_rows(mat: Vec<Vec<i32>>, num_select: i32) -> i32 {
        let m = mat.len();
        let n = mat[0].len();

        let mut row_masks: Vec<i32> = Vec::with_capacity(m);
        for i in 0..m {
            let mut mask = 0;
            for j in 0..n {
                if mat[i][j] == 1 {
                    mask |= 1 << j;
                }
            }
            row_masks.push(mask);
        }

        let mut max_covered_rows = 0;

        for i in 0..(1 << n) {
            if i.count_ones() as i32 == num_select {
                let selected_cols_mask = i;
                let mut current_covered_rows = 0;

                for &row_mask in &row_masks {
                    if (row_mask & selected_cols_mask) == row_mask {
                        current_covered_rows += 1;
                    }
                }
                max_covered_rows = max_covered_rows.max(current_covered_rows);
            }
        }

        max_covered_rows
    }
}