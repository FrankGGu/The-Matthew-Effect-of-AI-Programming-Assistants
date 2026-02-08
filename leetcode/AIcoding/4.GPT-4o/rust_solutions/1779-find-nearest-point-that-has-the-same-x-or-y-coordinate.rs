impl Solution {
    pub fn nearest_valid_point(x: i32, y: i32, points: Vec<Vec<i32>>) -> i32 {
        let mut min_distance = i32::MAX;
        let mut index = -1;

        for (i, point) in points.iter().enumerate() {
            if point[0] == x || point[1] == y {
                let distance = (point[0] - x).abs() + (point[1] - y).abs();
                if distance < min_distance {
                    min_distance = distance;
                    index = i as i32;
                }
            }
        }

        index
    }
}