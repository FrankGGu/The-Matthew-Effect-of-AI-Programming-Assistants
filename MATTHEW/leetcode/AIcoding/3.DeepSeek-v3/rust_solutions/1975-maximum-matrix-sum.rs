impl Solution {
    pub fn max_matrix_sum(matrix: Vec<Vec<i32>>) -> i64 {
        let mut sum = 0i64;
        let mut min_abs = i32::MAX;
        let mut neg_count = 0;

        for row in matrix {
            for num in row {
                let abs_num = num.abs();
                sum += abs_num as i64;
                min_abs = min_abs.min(abs_num);
                if num < 0 {
                    neg_count += 1;
                }
            }
        }

        if neg_count % 2 == 0 {
            sum
        } else {
            sum - 2 * min_abs as i64
        }
    }
}