impl Solution {
    pub fn is_reachable_at_time(sx: i32, sy: i32, fx: i32, fy: i32, t: i32) -> bool {
        let dx = (sx - fx).abs();
        let dy = (sy - fy).abs();
        let h = dx.max(dy);

        if h == 0 {
            return t != 0;
        }

        h <= t
    }
}