impl Solution {
    pub fn count_colored_cells(n: i32) -> i32 {
        if n == 1 {
            return 1;
        }
        return 3 * n * (n - 1) + 1;
    }
}