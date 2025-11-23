impl Solution {
    pub fn check_overlap(radius: i32, x_center: i32, y_center: i32, x1: i32, y1: i32, x2: i32, y2: i32) -> bool {
        let closest_x = x_center.max(x1).min(x2);
        let closest_y = y_center.max(y1).min(y2);

        let dist_x = (x_center - closest_x) as i64;
        let dist_y = (y_center - closest_y) as i64;

        let dist_sq = dist_x * dist_x + dist_y * dist_y;
        let radius_sq = (radius as i64) * (radius as i64);

        dist_sq <= radius_sq
    }
}