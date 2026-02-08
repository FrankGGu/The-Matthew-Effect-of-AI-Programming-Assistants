impl Solution {
    pub fn find_min_arrow_shots(points: Vec<Vec<i32>>) -> i32 {
        if points.is_empty() {
            return 0;
        }
        let mut points = points;
        points.sort_by_key(|p| p[1]);
        let mut arrows = 1;
        let mut end = points[0][1];

        for point in points.iter() {
            if point[0] > end {
                arrows += 1;
                end = point[1];
            }
        }

        arrows
    }
}