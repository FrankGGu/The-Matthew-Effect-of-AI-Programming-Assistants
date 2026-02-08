impl Solution {
    pub fn min_time_to_visit_all_points(points: Vec<Vec<i32>>) -> i32 {
        let mut time = 0;
        for i in 0..points.len() - 1 {
            let x1 = points[i][0];
            let y1 = points[i][1];
            let x2 = points[i + 1][0];
            let y2 = points[i + 1][1];
            time += std::cmp::max((x1 - x2).abs(), (y1 - y2).abs());
        }
        time
    }
}