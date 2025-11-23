impl Solution {
    pub fn largest_triangle_area(points: Vec<Vec<i32>>) -> f64 {
        let n = points.len();
        let mut max_area = 0.0;
        for i in 0..n {
            for j in i + 1..n {
                for k in j + 1..n {
                    let area = 0.5 * ((points[j][0] - points[i][0]) * (points[k][1] - points[i][1]) - (points[k][0] - points[i][0]) * (points[j][1] - points[i][1])).abs() as f64;
                    max_area = max_area.max(area);
                }
            }
        }
        max_area
    }
}