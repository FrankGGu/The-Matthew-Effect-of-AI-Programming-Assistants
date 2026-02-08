impl Solution {
    pub fn largest_submatrix(mut matrix: Vec<Vec<i32>>) -> i32 {
        let n = matrix.len();
        let m = matrix[0].len();
        let mut max_area = 0;

        for i in 0..n {
            for j in 0..m {
                if matrix[i][j] == 1 && i > 0 {
                    matrix[i][j] += matrix[i - 1][j];
                }
            }

            let mut current_row_heights = matrix[i].clone();
            current_row_heights.sort_unstable_by(|a, b| b.cmp(a));

            for k in 0..m {
                let current_height = current_row_heights[k];
                let current_width = (k + 1) as i32;
                max_area = max_area.max(current_height * current_width);
            }
        }

        max_area
    }
}