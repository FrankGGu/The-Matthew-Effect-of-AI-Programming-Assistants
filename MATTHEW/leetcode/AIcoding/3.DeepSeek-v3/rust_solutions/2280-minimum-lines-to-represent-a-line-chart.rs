impl Solution {
    pub fn minimum_lines(mut points: Vec<Vec<i32>>) -> i32 {
        if points.len() <= 2 {
            return (points.len() as i32) - 1;
        }
        points.sort_unstable();
        let mut lines = 1;
        for i in 2..points.len() {
            let (x0, y0) = (points[i-2][0] as i64, points[i-2][1] as i64);
            let (x1, y1) = (points[i-1][0] as i64, points[i-1][1] as i64);
            let (x2, y2) = (points[i][0] as i64, points[i][1] as i64);
            let area1 = (x1 - x0) * (y2 - y0);
            let area2 = (x2 - x0) * (y1 - y0);
            if area1 != area2 {
                lines += 1;
            }
        }
        lines
    }
}