use std::cmp::min;

pub fn connect_two_groups(points1: Vec<Vec<i32>>, points2: Vec<Vec<i32>>) -> i32 {
    let n = points1.len();
    let m = points2.len();
    let mut cost = vec![vec![0; m]; n];

    for i in 0..n {
        for j in 0..m {
            cost[i][j] = (points1[i][0] - points2[j][0]).abs() + (points1[i][1] - points2[j][1]).abs();
        }
    }

    let mut dp = vec![i32::MAX; 1 << n];
    dp[0] = 0;

    for j in 0..m {
        let mut new_dp = dp.clone();
        for mask in 0..(1 << n) {
            for i in 0..n {
                if mask & (1 << i) == 0 {
                    let new_mask = mask | (1 << i);
                    new_dp[new_mask] = min(new_dp[new_mask], dp[mask] + cost[i][j]);
                }
            }
        }
        dp = new_dp;
    }

    *dp.iter().min().unwrap()
}