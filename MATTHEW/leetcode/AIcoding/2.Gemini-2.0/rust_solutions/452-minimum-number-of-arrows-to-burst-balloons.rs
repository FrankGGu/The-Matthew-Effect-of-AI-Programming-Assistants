impl Solution {
    pub fn find_min_arrow_shots(points: Vec<Vec<i32>>) -> i32 {
        if points.is_empty() {
            return 0;
        }

        let mut points = points;
        points.sort_by(|a, b| a[1].cmp(&b[1]));

        let mut arrows = 1;
        let mut end = points[0][1];

        for i in 1..points.len() {
            if points[i][0] > end {
                arrows += 1;
                end = points[i][1];
            }
        }

        arrows
    }
}