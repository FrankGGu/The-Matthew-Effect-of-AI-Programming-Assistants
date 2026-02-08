impl Solution {
    pub fn lucky_numbers(matrix: Vec<Vec<i32>>) -> Vec<i32> {
        let mut result = Vec::new();
        for i in 0..matrix.len() {
            let mut min_val = i32::MAX;
            let mut min_col = 0;
            for j in 0..matrix[0].len() {
                if matrix[i][j] < min_val {
                    min_val = matrix[i][j];
                    min_col = j;
                }
            }
            let mut is_lucky = true;
            for k in 0..matrix.len() {
                if matrix[k][min_col] > min_val {
                    is_lucky = false;
                    break;
                }
            }
            if is_lucky {
                result.push(min_val);
            }
        }
        result
    }
}