impl Solution {
    pub fn count_points(points: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut results = Vec::with_capacity(queries.len());

        for query in queries {
            let cx = query[0];
            let cy = query[1];
            let r = query[2];
            let r_squared = r * r;
            let mut count = 0;

            for point in &points {
                let px = point[0];
                let py = point[1];

                let dx = px - cx;
                let dy = py - cy;

                let dist_squared = dx * dx + dy * dy;

                if dist_squared <= r_squared {
                    count += 1;
                }
            }
            results.push(count);
        }
        results
    }
}