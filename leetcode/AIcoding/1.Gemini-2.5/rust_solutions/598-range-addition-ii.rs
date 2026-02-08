impl Solution {
    pub fn max_count(m: i32, n: i32, ops: Vec<Vec<i32>>) -> i32 {
        let mut min_row = m;
        let mut min_col = n;

        for op in ops {
            min_row = min_row.min(op[0]);
            min_col = min_col.min(op[1]);
        }

        min_row * min_col
    }
}