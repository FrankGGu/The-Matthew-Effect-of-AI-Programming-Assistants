impl Solution {
    pub fn min_cost(houses: Vec<i32>, cost: Vec<Vec<i32>>, m: i32, n: i32, target: i32) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let target = target as usize;
        let mut dp = vec![vec![vec![std::i32::MAX; n]; target + 1];
        if houses[0] == 0 {
            for color in 0..n {
                dp[1][color] = cost[0][color];
            }
        } else {
            let color = (houses[0] - 1) as usize;
            dp[1][color] = 0;
        }

        for i in 1..m {
            let mut new_dp = vec![vec![vec![std::i32::MAX; n]; target + 1]];
            new_dp.resize(target + 1, vec![vec![std::i32::MAX; n]; target + 1]);
            for neighborhoods in 1..=target {
                for prev_color in 0..n {
                    if dp[neighborhoods][prev_color] == std::i32::MAX {
                        continue;
                    }
                    if houses[i] == 0 {
                        for curr_color in 0..n {
                            let new_neighborhoods = if curr_color == prev_color {
                                neighborhoods
                            } else {
                                neighborhoods + 1
                            };
                            if new_neighborhoods > target {
                                continue;
                            }
                            let total_cost = dp[neighborhoods][prev_color] + cost[i][curr_color];
                            if total_cost < new_dp[new_neighborhoods][curr_color] {
                                new_dp[new_neighborhoods][curr_color] = total_cost;
                            }
                        }
                    } else {
                        let curr_color = (houses[i] - 1) as usize;
                        let new_neighborhoods = if curr_color == prev_color {
                            neighborhoods
                        } else {
                            neighborhoods + 1
                        };
                        if new_neighborhoods > target {
                            continue;
                        }
                        let total_cost = dp[neighborhoods][prev_color];
                        if total_cost < new_dp[new_neighborhoods][curr_color] {
                            new_dp[new_neighborhoods][curr_color] = total_cost;
                        }
                    }
                }
            }
            dp = new_dp;
        }

        let mut result = std::i32::MAX;
        for color in 0..n {
            if dp[target][color] < result {
                result = dp[target][color];
            }
        }
        if result == std::i32::MAX {
            -1
        } else {
            result
        }
    }
}