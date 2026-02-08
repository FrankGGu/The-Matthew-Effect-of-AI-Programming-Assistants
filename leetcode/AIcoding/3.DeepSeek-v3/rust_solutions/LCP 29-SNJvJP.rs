impl Solution {
    pub fn orchestra_layout(num: i32, x_pos: i32, y_pos: i32) -> i32 {
        let n = num as i64;
        let x = x_pos as i64;
        let y = y_pos as i64;
        let layer = x.min(y).min(n - 1 - x).min(n - 1 - y);
        let first = 4 * layer * (n - layer);
        let offset;
        if x == layer {
            offset = y - layer + 1;
        } else if y == n - 1 - layer {
            offset = (n - 2 * layer - 1) + (x - layer) + 1;
        } else if x == n - 1 - layer {
            offset = 2 * (n - 2 * layer - 1) + (n - layer - 1 - y) + 1;
        } else {
            offset = 3 * (n - 2 * layer - 1) + (n - layer - 1 - x) + 1;
        }
        let total = first + offset;
        ((total - 1) % 9 + 1) as i32
    }
}