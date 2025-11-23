impl Solution {
    pub fn is_reachable_at_time(sx: i32, sy: i32, tx: i32, ty: i32, t: i32) -> bool {
        let dx = (sx - tx).abs();
        let dy = (sy - ty).abs();

        let min_time_required = std::cmp::max(dx, dy);

        if min_time_required == 0 {
            // If the start and target cells are the same.
            // If t = 0, we are already there.
            // If t = 1, we must move to an adjacent cell, so we cannot be at the target cell in exactly 1 second.
            // If t >= 2, we can move to an adjacent cell and then back to the starting cell in 2 steps,
            // and then wait for the remaining t-2 seconds.
            t != 1
        } else {
            // If the start and target cells are different.
            // The minimum time required to reach the target is the Chebyshev distance.
            // If t is less than this minimum time, it's impossible to reach.
            // If t is greater than or equal to the minimum time, it's always possible.
            // We can always "stretch" the path by 1 step (e.g., instead of moving diagonally, move horizontally then vertically).
            // This allows us to reach the target in min_time_required, min_time_required+1, ..., up to t steps.
            t >= min_time_required
        }
    }
}