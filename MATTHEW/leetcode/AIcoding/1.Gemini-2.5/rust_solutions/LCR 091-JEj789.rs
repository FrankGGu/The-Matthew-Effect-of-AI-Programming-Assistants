impl Solution {
    pub fn min_cost(costs: Vec<Vec<i32>>) -> i32 {
        if costs.is_empty() {
            return 0;
        }

        let n = costs.len();

        // dp0, dp1, dp2 represent the minimum cost to paint the current house
        // with color 0, 1, or 2 respectively.
        let mut dp0 = costs[0][0];
        let mut dp1 = costs[0][1];
        let mut dp2 = costs[0][2];

        for i in 1..n {
            let next_dp0 = costs[i][0] + dp1.min(dp2);
            let next_dp1 = costs[i][1] + dp0.min(dp2);
            let next_dp2 = costs[i][2] + dp0.min(dp1);

            dp0 = next_dp0;
            dp1 = next_dp1;
            dp2 = next_dp2;
        }

        dp0.min(dp1).min(dp2)
    }
}