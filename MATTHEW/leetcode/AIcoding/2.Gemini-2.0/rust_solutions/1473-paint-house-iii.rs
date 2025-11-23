impl Solution {
    pub fn min_cost(houses: Vec<i32>, cost: Vec<Vec<i32>>, m: i32, n: i32, target: i32) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let target = target as usize;

        let mut dp = vec![vec![vec![i32::MAX; target + 1]; n + 1]; m + 1];

        for j in 1..=n {
            if houses[0] == 0 {
                dp[1][j][1] = cost[0][j - 1];
            } else if houses[0] as usize == j {
                dp[1][j][1] = 0;
            }
        }

        for i in 2..=m {
            for j in 1..=n {
                for k in 1..=target.min(i) {
                    if houses[i - 1] != 0 && houses[i - 1] as usize != j {
                        continue;
                    }

                    let cur_cost = if houses[i - 1] == 0 { cost[i - 1][j - 1] } else { 0 };

                    for l in 1..=n {
                        if l == j {
                            if dp[i - 1][l][k] != i32::MAX {
                                dp[i][j][k] = dp[i][j][k].min(dp[i - 1][l][k] + cur_cost);
                            }
                        } else {
                            if k > 1 && dp[i - 1][l][k - 1] != i32::MAX {
                                dp[i][j][k] = dp[i][j][k].min(dp[i - 1][l][k - 1] + cur_cost);
                            }
                        }
                    }
                }
            }
        }

        let mut ans = i32::MAX;
        for j in 1..=n {
            ans = ans.min(dp[m][j][target]);
        }

        if ans == i32::MAX {
            -1
        } else {
            ans
        }
    }
}