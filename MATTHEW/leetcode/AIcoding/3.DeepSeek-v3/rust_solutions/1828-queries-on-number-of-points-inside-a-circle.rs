impl Solution {
    pub fn count_points(points: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        queries.iter().map(|query| {
            let x = query[0];
            let y = query[1];
            let r = query[2];
            points.iter().filter(|point| {
                let dx = point[0] - x;
                let dy = point[1] - y;
                dx * dx + dy * dy <= r * r
            }).count() as i32
        }).collect()
    }
}