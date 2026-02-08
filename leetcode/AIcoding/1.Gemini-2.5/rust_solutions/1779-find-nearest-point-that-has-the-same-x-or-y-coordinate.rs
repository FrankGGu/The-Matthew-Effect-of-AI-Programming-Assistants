impl Solution {
    pub fn nearest_valid_point(x: i32, y: i32, points: Vec<Vec<i32>>) -> i32 {
        let mut min_distance = i32::MAX;
        let mut min_index = -1;

        for (i, point) in points.iter().enumerate() {
            let px = point[0];
            let py = point[1];

            if px == x || py == y {
                let current_distance = (px - x).abs() + (py - y).abs();
                if current_distance < min_distance {
                    min_distance = current_distance;
                    min_index = i as i32;
                }
            }
        }
        min_index
    }
}