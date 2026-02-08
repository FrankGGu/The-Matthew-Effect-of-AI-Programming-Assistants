impl Solution {
    pub fn largest_area_of_square(bottom_left1: Vec<i32>, top_right1: Vec<i32>, bottom_left2: Vec<i32>, top_right2: Vec<i32>) -> i64 {
        let x1_1 = bottom_left1[0];
        let y1_1 = bottom_left1[1];
        let x1_2 = top_right1[0];
        let y1_2 = top_right1[1];

        let x2_1 = bottom_left2[0];
        let y2_1 = bottom_left2[1];
        let x2_2 = top_right2[0];
        let y2_2 = top_right2[1];

        let intersect_x_left = x1_1.max(x2_1);
        let intersect_y_bottom = y1_1.max(y2_1);
        let intersect_x_right = x1_2.min(x2_2);
        let intersect_y_top = y1_2.min(y2_2);

        if intersect_x_left >= intersect_x_right || intersect_y_bottom >= intersect_y_top {
            return 0;
        }

        let width = intersect_x_right - intersect_x_left;
        let height = intersect_y_top - intersect_y_bottom;

        let side = width.min(height);

        (side as i64) * (side as i64)
    }
}