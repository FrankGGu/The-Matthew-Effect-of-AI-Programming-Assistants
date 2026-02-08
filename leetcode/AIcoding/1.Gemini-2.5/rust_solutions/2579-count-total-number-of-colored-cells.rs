impl Solution {
    pub fn colored_cells(n: i32) -> i64 {
        let n_long = n as i64;
        1 + 2 * n_long * (n_long - 1)
    }
}