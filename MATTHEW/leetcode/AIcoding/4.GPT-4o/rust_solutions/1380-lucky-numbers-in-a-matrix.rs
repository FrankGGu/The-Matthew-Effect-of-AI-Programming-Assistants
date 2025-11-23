impl Solution {
    pub fn lucky_numbers(matrix: Vec<Vec<i32>>) -> Vec<i32> {
        let mut lucky_numbers = Vec::new();
        let rows = matrix.len();
        let cols = matrix[0].len();

        for i in 0..rows {
            let mut min_row = matrix[i][0];
            for j in 1..cols {
                min_row = min_row.min(matrix[i][j]);
            }
            let mut is_lucky = true;
            for k in 0..rows {
                if matrix[k].iter().any(|&x| x > min_row) {
                    is_lucky = false;
                    break;
                }
            }
            if is_lucky {
                lucky_numbers.push(min_row);
            }
        }

        lucky_numbers
    }
}