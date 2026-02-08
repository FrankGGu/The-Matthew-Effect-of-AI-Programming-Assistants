impl Solution {
    pub fn count_points(points: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut result: Vec<i32> = Vec::new();
        for query in &queries {
            let mut count = 0;
            for point in &points {
                let x = point[0];
                let y = point[1];
                let cx = query[0];
                let cy = query[1];
                let r = query[2];

                if (x - cx) * (x - cx) + (y - cy) * (y - cy) <= r * r {
                    count += 1;
                }
            }
            result.push(count);
        }
        result
    }
}