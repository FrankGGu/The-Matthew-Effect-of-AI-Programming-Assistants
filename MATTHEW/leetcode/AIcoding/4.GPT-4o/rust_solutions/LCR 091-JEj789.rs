impl Solution {
    pub fn min_cost(houses: Vec<i32>, cost: Vec<Vec<i32>>, m: i32, n: i32, target: i32) -> i32 {
        let inf = i32::MAX / 2;
        let mut dp = vec![vec![vec![inf; (target + 1) as usize]; (n + 1) as usize]; (m + 1) as usize];

        dp[0][0][0] = 0;

        for i in 0..m as usize {
            for j in 0..=n as usize {
                for k in 0..=target as usize {
                    if dp[i][j][k] == inf {
                        continue;
                    }
                    if houses[i] == 0 {
                        for color in 1..=n {
                            let new_k = if j + 1 == color { k } else { k + 1 };
                            if new_k <= target {
                                dp[i + 1][color as usize][new_k] = dp[i + 1][color as usize][new_k]
                                    .min(dp[i][j][k] + cost[i][(color - 1) as usize]);
                            }
                        }
                    } else {
                        let new_k = if j + 1 == houses[i] { k } else { k + 1 };
                        if new_k <= target {
                            dp[i + 1][houses[i] as usize][new_k] = dp[i + 1][houses[i] as usize][new_k]
                                .min(dp[i][j][k]);
                        }
                    }
                }
            }
        }

        let mut result = inf;
        for j in 1..=n {
            result = result.min(dp[m as usize][j as usize][target as usize]);
        }

        if result == inf {
            -1
        } else {
            result
        }
    }
}