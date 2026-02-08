impl Solution {
    pub fn max_matrix_sum(matrix: Vec<Vec<i32>>) -> i64 {
        let mut total_sum: i64 = 0;
        let mut negative_count: i32 = 0;
        let mut min_abs_val: i64 = i64::MAX;

        for row in matrix {
            for val in row {
                if val < 0 {
                    negative_count += 1;
                }
                let abs_val = (val as i64).abs();
                total_sum += abs_val;
                min_abs_val = min_abs_val.min(abs_val);
            }
        }

        if negative_count % 2 == 0 {
            total_sum
        } else {
            total_sum - 2 * min_abs_val
        }
    }
}