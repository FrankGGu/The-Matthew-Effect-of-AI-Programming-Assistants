pub fn min_cost_houses(costs: Vec<Vec<i32>>, m: i32, n: i32, target: i32) -> i32 {
    let inf = i32::MAX / 2;
    let m = m as usize;
    let n = n as usize;
    let target = target as usize;

    let mut dp = vec![vec![inf; target + 1]; m + 1];
    dp[0][0] = 0;

    for i in 1..=m {
        for j in 1..=target {
            for k in 0..n {
                let cost = costs[i - 1][k];
                for t in 0..=j - 1 {
                    dp[i][j] = dp[i][j].min(dp[i - 1][t] + cost);
                }
            }
        }
    }

    let mut res = inf;
    for j in 1..=target {
        res = res.min(dp[m][j]);
    }

    if res == inf { -1 } else { res }
}