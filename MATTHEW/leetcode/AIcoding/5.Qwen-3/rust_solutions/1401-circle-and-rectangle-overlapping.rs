struct Solution {}

impl Solution {
    pub fn check_overlap(
        radius: i32,
        x_center: i32,
        y_center: i32,
        x1: i32,
        y1: i32,
        x2: i32,
        y2: i32,
    ) -> bool {
        let mut closest_x = x_center;
        let mut closest_y = y_center;

        if x_center < x1 {
            closest_x = x1;
        } else if x_center > x2 {
            closest_x = x2;
        }

        if y_center < y1 {
            closest_y = y1;
        } else if y_center > y2 {
            closest_y = y2;
        }

        let dx = x_center - closest_x;
        let dy = y_center - closest_y;

        dx * dx + dy * dy <= radius * radius
    }
}