impl Solution {
    pub fn colored_cells(n: i32) -> i64 {
        if n == 1 {
            1
        } else {
            (n as i64) * (n as i64) + (n as i64 - 1) * (n as i64 - 1)
        }
    }
}