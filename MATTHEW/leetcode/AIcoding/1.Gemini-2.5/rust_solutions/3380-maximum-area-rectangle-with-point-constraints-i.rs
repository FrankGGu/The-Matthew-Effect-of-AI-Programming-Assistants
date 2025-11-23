impl Solution {
    pub fn max_area_rectangle_with_point_constraints(points: Vec<Vec<i32>>) -> i32 {
        let mut max_x = 0;
        let mut max_y = 0;

        for point in points {
            let px = point[0];
            let py = point[1];

            if px > max_x {
                max_x = px;
            }
            if py > max_y {
                max_y = py;
            }
        }

        max_x * max_y
    }
}