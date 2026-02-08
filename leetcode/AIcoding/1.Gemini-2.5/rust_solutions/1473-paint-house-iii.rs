struct Solution;

impl Solution {
    pub fn min_cost(houses: Vec<i32>, cost: Vec<Vec<i32>>, m: i32, n: i32, target: i32) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let target = target as usize;

        const INF: i32 = 1_000_000_001;

        // dp[k][j] = min cost to paint houses 0 to i-1 such that house i-1 is painted with color j (1-indexed),
        // and there are k neighborhoods.
        // We use a 2D DP table, where the first dimension is neighborhoods (k) and second is color (j).
        // We will update this table iteratively for each house.
        let mut dp: Vec<Vec<i32>> = vec![vec![INF; n + 1]; target + 1];

        // Base case: House 0
        let h0_color = houses[0];
        if h0_color == 0 { // House 0 is unpainted
            for c in 1..=n {
                dp[1][c] = cost[0][c - 1];
            }
        } else { // House 0 is already painted
            // If the first house is pre-painted, it forms 1 neighborhood with 0 cost.
            // If target is 1, this is a valid start. If target > 1, this is also a valid start.
            dp[1][h0_color as usize] = 0;
        }

        // Iterate for houses from 1 to m-1
        for i in 1..m {
            let mut next_dp: Vec<Vec<i32>> = vec![vec![INF; n + 1]; target + 1];

            // Precompute the two minimum costs and their colors for the previous house (i-1)
            // for each possible number of neighborhoods (k_prev).
            // This is used for the optimization in the 'new neighborhood' case.
            // min_info_for_prev_house[k_prev] = ((cost1, color1), (cost2, color2))
            let mut min_info_for_prev_house: Vec<((i32, usize), (i32, usize))> =
                vec![((INF, 0), (INF, 0)); target + 1];

            for k_prev in 1..=target {
                let mut best1 = (INF, 0); // (cost, color)
                let mut best2 = (INF, 0);

                for c_prev in 1..=n {
                    if dp[k_prev][c_prev] < best1.0 {
                        best2 = best1;
                        best1 = (dp[k_prev][c_prev], c_prev);
                    } else if dp[k_prev][c_prev] < best2.0 {
                        best2 = (dp[k_prev][c_prev], c_prev);
                    }
                }
                min_info_for_prev_house[k_prev] = (best1, best2);
            }

            // Iterate for current number of neighborhoods (k)
            for k in 1..=target {
                // Iterate for current color (current_color) for house i
                for current_color in 1..=n {
                    // Check if house i can be painted with current_color
                    let h_i_color = houses[i];
                    if h_i_color != 0 && h_i_color as usize != current_color {
                        continue; // House i is already painted with a different color
                    }

                    let current_house_paint_cost = if h_i_color == 0 {
                        cost[i][current_color - 1]
                    } else {
                        0 // Already painted, no cost
                    };

                    // Case 1: current_color is the same as prev_color (no new neighborhood)
                    // This means house i-1 also had current_color and k neighborhoods.
                    if dp[k][current_color] != INF {
                        next_dp[k][current_color] =
                            next_dp[k][current_color].min(dp[k][current_color] + current_house_paint_cost);
                    }

                    // Case 2: current_color is different from prev_color (a new neighborhood is formed)
                    // This means house i-1 had k-1 neighborhoods.
                    if k > 1 { // Need at least 2 neighborhoods for this case (k-1 >= 1)
                        let (best1, best2) = min_info_for_prev_house[k - 1];

                        let mut cost_from_prev_house = INF;
                        if current_color != best1.1 { // If current_color is not the best color from previous state
                            cost_from_prev_house = best1.0;
                        } else { // If current_color is the best color, use the second best
                            cost_from_prev_house = best2.0;
                        }

                        if cost_from_prev_house != INF {
                            next_dp[k][current_color] =
                                next_dp[k][current_color].min(cost_from_prev_house + current_house_paint_cost);
                        }
                    }
                }
            }
            dp = next_dp; // Move to the next house
        }

        // Find the minimum cost for target neighborhoods at the last house (m-1)
        let mut min_total_cost = INF;
        for c in 1..=n {
            min_total_cost = min_total_cost.min(dp[target][c]);
        }

        if min_total_cost == INF {
            -1
        } else {
            min_total_cost
        }
    }
}