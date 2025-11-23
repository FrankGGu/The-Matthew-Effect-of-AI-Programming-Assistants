impl Solution {
    pub fn min_cost_to_equalize_array(nums: Vec<i32>, cost: Vec<i32>) -> i64 {
        let mut nums_cost: Vec<(i32, i32)> = nums.into_iter().zip(cost.into_iter()).collect();
        nums_cost.sort();

        let mut prefix_sum: Vec<i64> = vec![0; nums_cost.len()];
        prefix_sum[0] = nums_cost[0].1 as i64;
        for i in 1..nums_cost.len() {
            prefix_sum[i] = prefix_sum[i - 1] + nums_cost[i].1 as i64;
        }

        let mut median = nums_cost[0].0;
        let mut min_cost = 0i64;
        for i in 0..nums_cost.len() {
            min_cost += (nums_cost[i].0 as i64 - median as i64).abs() * nums_cost[i].1 as i64;
        }

        for i in 1..nums_cost.len() {
            let current_median = nums_cost[i].0;
            let mut current_cost = 0i64;
            for j in 0..nums_cost.len() {
                current_cost += (nums_cost[j].0 as i64 - current_median as i64).abs() * nums_cost[j].1 as i64;
            }

            min_cost = min_cost.min(current_cost);
        }

        min_cost
    }
}