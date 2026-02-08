impl Solution {
    pub fn max_distance(points: Vec<Vec<i32>>) -> i32 {
        let mut min_x = i32::MAX;
        let mut max_x = i32::MIN;
        let mut min_y = i32::MAX;
        let mut max_y = i32::MIN;

        for point in points {
            min_x = min_x.min(point[0]);
            max_x = max_x.max(point[0]);
            min_y = min_y.min(point[1]);
            max_y = max_y.max(point[1]);
        }

        let d1 = (max_x - min_x).pow(2) + (max_y - min_y).pow(2);
        let d2 = (max_x - min_x).pow(2) + (min_y - max_y).pow(2);
        let d3 = (min_x - max_x).pow(2) + (max_y - min_y).pow(2);
        let d4 = (min_x - max_x).pow(2) + (min_y - max_y).pow(2);

        d1.max(d2).max(d3).max(d4).sqrt() as i32
    }
}