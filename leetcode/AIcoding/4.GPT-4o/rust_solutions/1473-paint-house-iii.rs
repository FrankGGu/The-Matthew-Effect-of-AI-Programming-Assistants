impl Solution {
    pub fn min_cost(houses: Vec<i32>, cost: Vec<Vec<i32>>, m: i32, n: i32, target: i32) -> i32 {
        let inf = 1_000_000_000;
        let mut dp = vec![vec![vec![inf; target as usize + 1]; n as usize + 1]; m as usize + 1];
        dp[0][0][0] = 0;

        for i in 0..m {
            for j in 0..=n {
                for k in 0..=target {
                    if dp[i as usize][j as usize][k as usize] == inf {
                        continue;
                    }
                    if houses[i as usize] == 0 {
                        for color in 1..=n {
                            let new_k = if j == color { k } else { k + 1 };
                            if new_k as usize <= target as usize {
                                dp[(i + 1) as usize][color as usize][new_k as usize] = 
                                    dp[(i + 1) as usize][color as usize][new_k as usize]
                                    .min(dp[i as usize][j as usize][k as usize] + cost[i as usize][(color - 1) as usize]);
                            }
                        }
                    } else {
                        let color = houses[i as usize];
                        let new_k = if j == color { k } else { k + 1 };
                        if new_k as usize <= target as usize {
                            dp[(i + 1) as usize][color as usize][new_k as usize] = 
                                dp[(i + 1) as usize][color as usize][new_k as usize]
                                .min(dp[i as usize][j as usize][k as usize]);
                        }
                    }
                }
            }
        }

        let mut ans = inf;
        for j in 1..=n {
            ans = ans.min(dp[m as usize][j as usize][target as usize]);
        }

        if ans == inf { -1 } else { ans }
    }
}