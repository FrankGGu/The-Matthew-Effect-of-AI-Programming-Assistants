impl Solution {
    pub fn minimum_levels(points: Vec<i32>) -> i32 {
        let mut levels = 0;
        let mut total_points = 0;

        for &point in points.iter() {
            if total_points + point > 0 {
                total_points += point;
                levels += 1;
            }
        }

        levels
    }
}