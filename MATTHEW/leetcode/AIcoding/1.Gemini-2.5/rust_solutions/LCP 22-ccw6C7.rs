impl Solution {
    pub fn solve(n: i64, m: i64, k: i64) -> i64 {
        let total_cells = n * m;
        let b_compat_count = (total_cells + 1) / 2;
        let w_compat_count = total_cells / 2;
        let num_paint_black = k;
        let num_paint_white = total_cells - k;
        let correctly_painted_black = num_paint_black.min(b_compat_count);
        let correctly_painted_white = num_paint_white.min(w_compat_count);
        correctly_painted_black + correctly_painted_white
    }
}