struct Solution;

impl Solution {
    pub fn count_points(points: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut result = Vec::new();
        for query in queries {
            let (xq, yq, rq) = (query[0], query[1], query[2]);
            let mut count = 0;
            for point in &points {
                let (xp, yp) = (point[0], point[1]);
                if (xp - xq).pow(2) + (yp - yq).pow(2) <= rq.pow(2) {
                    count += 1;
                }
            }
            result.push(count);
        }
        result
    }
}