impl Solution {

use std::cmp::min;

impl Solution {
    pub fn min_cost(
        mut houses: Vec<Vec<i32>>,
        mut cost: Vec<Vec<i32>>,
        m: i32,
        n: i32,
        k: i32,
    ) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let k = k as usize;
        let mut dp = vec![vec![vec![i32::MAX; n]; k]; m];

        for j in 0..n {
            dp[0][0][j] = houses[0][j];
        }

        for i in 1..m {
            for prev_color in 0..n {
                if dp[i-1][0][prev_color] == i32::MAX {
                    continue;
                }
                for curr_color in 0..n {
                    if prev_color == curr_color {
                        continue;
                    }
                    let cost_to_paint = if houses[i][curr_color] == 0 {
                        cost[i][curr_color]
                    } else {
                        0
                    };
                    dp[i][0][curr_color] = min(
                        dp[i][0][curr_color],
                        dp[i-1][0][prev_color] + cost_to_paint
                    );
                }
            }
        }

        for i in 1..m {
            for color in 0..n {
                if houses[i][color] == 0 {
                    for prev_color in 0..n {
                        if prev_color == color {
                            continue;
                        }
                        dp[i][0][color] = min(
                            dp[i][0][color],
                            dp[i-1][0][prev_color] + cost[i][color]
                        );
                    }
                }
            }
        }

        let mut res = i32::MAX;
        for color in 0..n {
            res = min(res, dp[m-1][0][color]);
        }

        if res == i32::MAX {
            -1
        } else {
            res
        }
    }
}
}