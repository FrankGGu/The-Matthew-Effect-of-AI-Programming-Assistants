impl Solution {
    pub fn max_distance(x: Vec<i32>, y: Vec<i32>) -> i32 {
        let mut max_dist = 0;
        let n = x.len();
        for i in 0..n {
            for j in i+1..n {
                let dx = (x[i] - x[j]).abs();
                let dy = (y[i] - y[j]).abs();
                let dist = dx.max(dy);
                if dist > max_dist {
                    max_dist = dist;
                }
            }
        }
        max_dist
    }
}