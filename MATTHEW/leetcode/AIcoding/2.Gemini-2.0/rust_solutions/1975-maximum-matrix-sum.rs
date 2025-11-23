impl Solution {
    pub fn max_matrix_sum(matrix: Vec<Vec<i32>>) -> i64 {
        let mut neg_count = 0;
        let mut sum = 0i64;
        let mut min_abs = i32::MAX;

        for row in &matrix {
            for &num in row {
                if num < 0 {
                    neg_count += 1;
                }
                sum += num.abs() as i64;
                min_abs = min_abs.min(num.abs());
            }
        }

        if neg_count % 2 == 0 {
            sum
        } else {
            sum - 2 * min_abs as i64
        }
    }
}