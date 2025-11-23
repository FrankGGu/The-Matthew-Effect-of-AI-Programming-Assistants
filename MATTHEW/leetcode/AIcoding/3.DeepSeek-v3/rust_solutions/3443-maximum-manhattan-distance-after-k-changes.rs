impl Solution {
    pub fn max_manhattan_distance(points: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = points.len();
        let mut x = vec![0; n];
        let mut y = vec![0; n];
        for i in 0..n {
            x[i] = points[i][0] + points[i][1];
            y[i] = points[i][0] - points[i][1];
        }
        x.sort();
        y.sort();
        let mut res = 0;
        let k = k as usize;
        for i in 0..=k {
            let j = k - i;
            if i >= n || j >= n {
                continue;
            }
            let current = (x[n - 1 - i] - x[0 + j]).max(y[n - 1 - i] - y[0 + j]);
            res = res.max(current);
        }
        res
    }
}