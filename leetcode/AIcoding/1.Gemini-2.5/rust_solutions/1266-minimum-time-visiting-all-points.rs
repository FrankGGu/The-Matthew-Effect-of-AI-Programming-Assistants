impl Solution {
    pub fn min_time_to_visit_all_points(points: Vec<Vec<i32>>) -> i32 {
        let mut total_time = 0;

        for i in 0..points.len() - 1 {
            let p1 = &points[i];
            let p2 = &points[i + 1];

            let dx = (p2[0] - p1[0]).abs();
            let dy = (p2[1] - p1[1]).abs();

            total_time += dx.max(dy);
        }

        total_time
    }
}