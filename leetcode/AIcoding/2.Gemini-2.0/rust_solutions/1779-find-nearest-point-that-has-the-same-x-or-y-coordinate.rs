impl Solution {
    pub fn nearest_valid_point(x: i32, y: i32, points: Vec<Vec<i32>>) -> i32 {
        let mut min_dist = i32::MAX;
        let mut min_index = -1;

        for (i, point) in points.iter().enumerate() {
            if point[0] == x || point[1] == y {
                let dist = (point[0] - x).abs() + (point[1] - y).abs();
                if dist < min_dist {
                    min_dist = dist;
                    min_index = i as i32;
                }
            }
        }

        min_index
    }
}