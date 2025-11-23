impl Solution {
    pub fn max_matrix_sum(matrix: Vec<Vec<i32>>) -> i64 {
        let mut total_sum = 0;
        let mut min_abs = i32::MAX;
        let mut negative_count = 0;

        for row in &matrix {
            for &num in row {
                total_sum += num.abs();
                if num < 0 {
                    negative_count += 1;
                }
                min_abs = min_abs.min(num.abs());
            }
        }

        if negative_count % 2 == 0 {
            total_sum as i64
        } else {
            total_sum as i64 - 2 * min_abs as i64
        }
    }
}