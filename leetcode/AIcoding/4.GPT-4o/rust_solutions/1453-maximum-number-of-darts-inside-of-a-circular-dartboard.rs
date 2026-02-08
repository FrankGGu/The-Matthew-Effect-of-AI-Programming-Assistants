impl Solution {
    pub fn num_darts(points: Vec<Vec<i32>>, r: i32) -> i32 {
        let r_squared = r * r;
        let mut count = 0;

        for i in 0..points.len() {
            let (x1, y1) = (points[i][0], points[i][1]);
            let mut current_count = 1;
            for j in (i + 1)..points.len() {
                let (x2, y2) = (points[j][0], points[j][1]);
                if (x1 - x2).pow(2) + (y1 - y2).pow(2) <= r_squared {
                    current_count += 1;
                }
            }
            count = count.max(current_count);
        }

        count
    }
}