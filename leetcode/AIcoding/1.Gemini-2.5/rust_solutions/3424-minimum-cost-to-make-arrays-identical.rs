impl Solution {
    fn calculate_total_cost(nums: &[i32], costs: &[i32], target: i32) -> i64 {
        let mut total_cost = 0i64;
        for i in 0..nums.len() {
            total_cost += (nums[i] as i64 - target as i64).abs() * costs[i] as i64;
        }
        total_cost
    }

    pub fn min_cost(nums: Vec<i32>, cost: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut pairs: Vec<(i32, i32)> = Vec::with_capacity(n);
        for i in 0..n {
            pairs.push((nums[i], cost[i]));
        }

        // Sort pairs by nums[i] to find the weighted median
        pairs.sort_unstable_by_key(|p| p.0);

        let mut total_cost_sum = 0i64;
        for i in 0..n {
            total_cost_sum += pairs[i].1 as i64;
        }

        let mut current_cost_sum = 0i64;
        let mut optimal_x = 0;

        // Find the weighted median. The optimal_x is the first nums[i]
        // where the cumulative cost sum (from the left) is at least half of the total cost sum.
        for i in 0..n {
            current_cost_sum += pairs[i].1 as i64;
            if current_cost_sum * 2 >= total_cost_sum {
                optimal_x = pairs[i].0;
                break;
            }
        }

        Self::calculate_total_cost(&nums, &cost, optimal_x)
    }
}