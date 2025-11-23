impl Solution {
    pub fn min_cost_ii(costs: Vec<Vec<i32>>, target: i32) -> i32 {
        let n = costs.len();
        let k = if n > 0 { costs[0].len() } else { 0 };

        if n == 0 {
            if target == 0 {
                return 0;
            } else {
                return -1;
            }
        }

        if target > n {
            return -1;
        }

        let mut dp = vec![vec![i32::MAX; target as usize + 1]; n + 1];

        dp[0][0] = 0;

        for i in 1..=n {
            for j in 1..=target as usize + 1 {
                for l in 0..k {
                    if dp[i - 1][j - 1] != i32::MAX {
                        dp[i][j] = dp[i][j].min(dp[i - 1][j - 1] + costs[i - 1][l]);
                    }
                }

                for prev_j in 1..j {
                    if dp[i-1][prev_j] != i32::MAX {
                        dp[i][j] = dp[i][j].min(dp[i-1][prev_j]);
                    }
                }
            }

            let mut min1 = i32::MAX;
            let mut min2 = i32::MAX;
            let mut idx1 = -1;

            for prev_j in 1..=target as usize {
                if dp[i-1][prev_j] < min1 {
                    min2 = min1;
                    min1 = dp[i-1][prev_j];
                    idx1 = (prev_j - 1) as i32;
                } else if dp[i-1][prev_j] < min2 {
                    min2 = dp[i-1][prev_j];
                }
            }

            for j in 1..=target as usize {
               if dp[i][j] == i32::MAX {
                    continue;
               }

               for l in 0..k {
                    let mut cost = i32::MAX;
                    if idx1 != -1 {
                        if (j - 1) as i32 == idx1 {
                            if min2 != i32::MAX {
                                cost = min2 + costs[i-1][l];
                            }
                        } else {
                            cost = min1 + costs[i-1][l];
                        }
                    }

                    if cost != i32::MAX {
                        dp[i][j] = dp[i][j].min(cost);
                    }
               }
            }

            let mut min_val = i32::MAX;
            for j in 1..=target as usize {
                min_val = min_val.min(dp[i][j]);
            }
        }

        if dp[n][target as usize] == i32::MAX {
            return -1;
        }

        dp[n][target as usize]
    }
}