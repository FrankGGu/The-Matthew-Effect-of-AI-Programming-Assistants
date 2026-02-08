const INF: i32 = std::i32::MAX / 2;

impl Solution {
    pub fn min_cost(houses: Vec<i32>, cost: Vec<Vec<i32>>, m: i32, n: i32, target: i32) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let target = target as usize;

        let mut dp = vec![vec![vec![INF; target + 1]; n]; m];

        for j in 0..n {
            if houses[0] == 0 {
                dp[0][j][1] = cost[0][j];
            } else if houses[0] == (j + 1) as i32 {
                dp[0][j][1] = 0;
            }
        }

        for i in 1..m {
            let mut min_costs_prev_k: Vec<(i32, usize, i32, usize)> = vec![(INF, 0, INF, 0); target + 1];

            for k_val in 1..=target {
                let mut current_min1_cost = INF;
                let mut current_min1_idx = 0;
                let mut current_min2_cost = INF;
                let mut current_min2_idx = 0;

                for prev_j in 0..n {
                    let val = dp[i - 1][prev_j][k_val];
                    if val < current_min1_cost {
                        current_min2_cost = current_min1_cost;
                        current_min2_idx = current_min1_idx;
                        current_min1_cost = val;
                        current_min1_idx = prev_j;
                    } else if val < current_min2_cost {
                        current_min2_cost = val;
                        current_min2_idx = prev_j;
                    }
                }
                min_costs_prev_k[k_val] = (current_min1_cost, current_min1_idx, current_min2_cost, current_min2_idx);
            }

            for j in 0..n {
                if houses[i] != 0 && houses[i] != (j + 1) as i32 {
                    continue;
                }

                let current_paint_cost = if houses[i] == 0 { cost[i][j] } else { 0 };

                for k in 1..=target {
                    if dp[i - 1][j][k] != INF {
                        dp[i][j][k] = dp[i][j][k].min(dp[i - 1][j][k] + current_paint_cost);
                    }

                    if k > 1 {
                        let (min1_val, min1_idx, min2_val, _) = min_costs_prev_k[k - 1];

                        if j == min1_idx {
                            if min2_val != INF {
                                dp[i][j][k] = dp[i][j][k].min(min2_val + current_paint_cost);
                            }
                        } else {
                            if min1_val != INF {
                                dp[i][j][k] = dp[i][j][k].min(min1_val + current_paint_cost);
                            }
                        }
                    }
                }
            }
        }

        let mut min_total_cost = INF;
        for j in 0..n {
            min_total_cost = min_total_cost.min(dp[m - 1][j][target]);
        }

        if min_total_cost == INF {
            -1
        } else {
            min_total_cost
        }
    }
}