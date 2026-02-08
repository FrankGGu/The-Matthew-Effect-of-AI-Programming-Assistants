impl Solution {
    pub fn min_distance(mut houses: Vec<i32>, k: i32) -> i32 {
        let n = houses.len();
        houses.sort_unstable();

        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + houses[i];
        }

        let mut cost = vec![vec![0; n]; n];
        for j in 0..n {
            for i in j..n {
                let mid_idx = j + (i - j) / 2;
                let median_house = houses[mid_idx];

                let mut current_cost = (mid_idx - j + 1) as i32 * median_house - (prefix_sum[mid_idx + 1] - prefix_sum[j]);
                current_cost += (prefix_sum[i + 1] - prefix_sum[mid_idx + 1]) - (i - mid_idx) as i32 * median_house;

                cost[j][i] = current_cost;
            }
        }

        let k_usize = k as usize;
        let mut dp = vec![vec![i32::MAX / 2; n + 1]; k_usize + 1];

        dp[0][0] = 0;

        for k_val in 1..=k_usize {
            for i in 1..=n {
                if i < k_val {
                    continue;
                }
                for j in 0..i {
                    if dp[k_val - 1][j] != i32::MAX / 2 {
                        dp[k_val][i] = dp[k_val][i].min(dp[k_val - 1][j] + cost[j][i - 1]);
                    }
                }
            }
        }

        dp[k_usize][n]
    }
}