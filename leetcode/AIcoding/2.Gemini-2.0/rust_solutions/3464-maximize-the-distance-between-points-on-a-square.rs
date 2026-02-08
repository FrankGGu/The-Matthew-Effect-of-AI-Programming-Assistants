impl Solution {
    pub fn max_distance(points: Vec<Vec<i32>>) -> i32 {
        let mut min_x = i32::MAX;
        let mut max_x = i32::MIN;
        let mut min_y = i32::MAX;
        let mut max_y = i32::MIN;

        for point in &points {
            min_x = min_x.min(point[0]);
            max_x = max_x.max(point[0]);
            min_y = min_y.min(point[1]);
            max_y = max_y.max(point[1]);
        }

        let side1 = max_x - min_x;
        let side2 = max_y - min_y;

        side1.max(side2)
    }
}