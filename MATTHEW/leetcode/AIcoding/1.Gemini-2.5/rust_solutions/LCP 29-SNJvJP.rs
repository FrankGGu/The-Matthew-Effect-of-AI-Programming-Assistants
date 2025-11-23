impl Solution {
    pub fn orchestra_seating(n: i32, x: i32, y: i32) -> i32 {
        let dist_top = x;
        let dist_bottom = n - 1 - x;
        let dist_left = y;
        let dist_right = n - 1 - y;

        let min_dist_to_border = dist_top
            .min(dist_bottom)
            .min(dist_left)
            .min(dist_right);

        min_dist_to_border + 1
    }
}