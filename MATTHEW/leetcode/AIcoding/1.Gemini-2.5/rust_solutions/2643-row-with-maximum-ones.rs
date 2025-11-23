impl Solution {
    pub fn row_with_maximum_ones(mat: Vec<Vec<i32>>) -> Vec<i32> {
        let mut max_ones_count = 0;
        let mut result_row_index = 0;

        for (row_idx, row) in mat.iter().enumerate() {
            let current_ones_count = row.iter().filter(|&&x| x == 1).count() as i32;

            if current_ones_count > max_ones_count {
                max_ones_count = current_ones_count;
                result_row_index = row_idx as i32;
            }
        }

        vec![result_row_index, max_ones_count]
    }
}