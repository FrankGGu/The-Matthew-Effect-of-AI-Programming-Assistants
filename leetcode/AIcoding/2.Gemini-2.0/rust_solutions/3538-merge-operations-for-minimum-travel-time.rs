impl Solution {
    pub fn min_travel_time(locations: Vec<Vec<i32>>) -> f64 {
        let n = locations.len();
        let mut dist = vec![vec![0.0; n]; n];
        for i in 0..n {
            for j in 0..n {
                dist[i][j] = (((locations[i][0] - locations[j][0]).pow(2) + (locations[i][1] - locations[j][1]).pow(2)) as f64).sqrt();
            }
        }

        let mut dp = vec![vec![f64::MAX; n]; 1 << n];
        dp[1][0] = 0.0;

        for mask in 1..(1 << n) {
            for i in 0..n {
                if (mask & (1 << i)) != 0 {
                    for j in 0..n {
                        if i != j && (mask & (1 << j)) != 0 {
                            let prev_mask = mask ^ (1 << i);
                            dp[mask][i] = dp[mask][i].min(dp[prev_mask][j] + dist[j][i]);
                        }
                    }
                }
            }
        }

        let mut ans = f64::MAX;
        for i in 0..n {
            ans = ans.min(dp[(1 << n) - 1][i]);
        }

        ans
    }
}