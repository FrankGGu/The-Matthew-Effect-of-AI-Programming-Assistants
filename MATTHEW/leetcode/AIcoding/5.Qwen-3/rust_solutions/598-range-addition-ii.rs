struct Solution;

impl Solution {
    pub fn max_count(max_total: i32, ops: Vec<Vec<i32>>) -> i32 {
        let mut min_row = max_total;
        let mut min_col = max_total;

        for op in ops {
            min_row = std::cmp::min(min_row, op[0]);
            min_col = std::cmp::min(min_col, op[1]);
        }

        min_row * min_col
    }
}