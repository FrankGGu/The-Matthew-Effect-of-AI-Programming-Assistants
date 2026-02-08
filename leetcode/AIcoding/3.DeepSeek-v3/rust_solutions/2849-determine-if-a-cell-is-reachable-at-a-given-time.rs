impl Solution {
    pub fn is_reachable_at_time(sx: i32, sy: i32, fx: i32, fy: i32, t: i32) -> bool {
        let dx = (fx - sx).abs();
        let dy = (fy - sy).abs();
        let min_steps = std::cmp::max(dx, dy);
        if min_steps == 0 {
            t != 1
        } else {
            t >= min_steps
        }
    }
}