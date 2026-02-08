impl Solution {
    pub fn min_cost(houses: Vec<i32>, cost: Vec<Vec<i32>>, m: i32, n: i32, target: i32) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let target = target as usize;
        let mut dp = vec![vec![vec![std::i32::MAX; n]; target + 1]; m + 1];
        if houses[0] == 0 {
            for color in 0..n {
                dp[1][1][color] = cost[0][color];
            }
        } else {
            let color = (houses[0] - 1) as usize;
            dp[1][1][color] = 0;
        }

        for i in 1..m {
            for k in 1..=target {
                for prev_color in 0..n {
                    if dp[i][k][prev_color] == std::i32::MAX {
                        continue;
                    }
                    if houses[i] == 0 {
                        for curr_color in 0..n {
                            let new_k = if curr_color == prev_color { k } else { k + 1 };
                            if new_k > target {
                                continue;
                            }
                            let new_cost = dp[i][k][prev_color] + cost[i][curr_color];
                            if new_cost < dp[i + 1][new_k][curr_color] {
                                dp[i + 1][new_k][curr_color] = new_cost;
                            }
                        }
                    } else {
                        let curr_color = (houses[i] - 1) as usize;
                        let new_k = if curr_color == prev_color { k } else { k + 1 };
                        if new_k > target {
                            continue;
                        }
                        let new_cost = dp[i][k][prev_color];
                        if new_cost < dp[i + 1][new_k][curr_color] {
                            dp[i + 1][new_k][curr_color] = new_cost;
                        }
                    }
                }
            }
        }

        let mut result = std::i32::MAX;
        for color in 0..n {
            if dp[m][target][color] < result {
                result = dp[m][target][color];
            }
        }
        if result == std::i32::MAX {
            -1
        } else {
            result
        }
    }
}