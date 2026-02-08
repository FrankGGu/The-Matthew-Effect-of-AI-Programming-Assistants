impl Solution {
    pub fn min_time_to_visit_all_points(points: Vec<Vec<i32>>) -> i32 {
        let mut total_time = 0;
        for i in 1..points.len() {
            let x_diff = (points[i][0] - points[i-1][0]).abs();
            let y_diff = (points[i][1] - points[i-1][1]).abs();
            total_time += std::cmp::max(x_diff, y_diff);
        }
        total_time
    }
}