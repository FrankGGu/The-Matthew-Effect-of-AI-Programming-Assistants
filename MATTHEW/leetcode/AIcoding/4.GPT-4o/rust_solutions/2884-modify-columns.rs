impl Solution {
    pub fn modify_columns(matrix: &mut Vec<Vec<i32>>, row: i32, col: i32) {
        let rows = matrix.len();
        let cols = matrix[0].len();
        let target_value = matrix[row as usize][col as usize];

        for i in 0..rows {
            for j in 0..cols {
                if i == row as usize || j == col as usize {
                    matrix[i][j] = target_value;
                }
            }
        }
    }
}