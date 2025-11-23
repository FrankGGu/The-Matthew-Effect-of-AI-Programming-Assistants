impl Solution {
    pub fn separate_squares(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        let mut ans = 0;
        for i in 0..n {
            for j in i + 1..n {
                let mut cnt = 0;
                for k in 0..n {
                    let cross = (points[j][0] - points[i][0]) * (points[k][1] - points[i][1]) - (points[j][1] - points[i][1]) * (points[k][0] - points[i][0]);
                    if cross > 0 {
                        cnt += 1;
                    }
                }
                if cnt > 0 && cnt < n {
                    ans += 1;
                }
            }
        }
        ans
    }
}