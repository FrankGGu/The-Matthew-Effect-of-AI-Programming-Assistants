pub fn max_points(points: Vec<Vec<i32>>) -> i32 {
    let n = points.len();
    let mut dp = vec![0; n + 1];

    for i in 0..n {
        let mut temp = dp.clone();
        for j in 0..=i {
            temp[j + 1] = temp[j + 1].max(dp[j] + points[i][0] - (j as i32) * points[i][1]);
        }
        dp = temp;
    }

    *dp.iter().max().unwrap()
}