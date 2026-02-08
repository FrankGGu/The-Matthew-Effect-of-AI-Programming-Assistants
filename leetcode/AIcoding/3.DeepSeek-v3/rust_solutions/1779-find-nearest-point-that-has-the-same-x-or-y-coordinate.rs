impl Solution {
    pub fn nearest_valid_point(x: i32, y: i32, points: Vec<Vec<i32>>) -> i32 {
        let mut min_dist = std::i32::MAX;
        let mut result = -1;

        for (i, point) in points.iter().enumerate() {
            let (px, py) = (point[0], point[1]);
            if px == x || py == y {
                let dist = (px - x).abs() + (py - y).abs();
                if dist < min_dist {
                    min_dist = dist;
                    result = i as i32;
                }
            }
        }

        result
    }
}