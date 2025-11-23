impl Solution {
    pub fn min_cost(nums: Vec<i32>, cost: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut pairs: Vec<(i32, i32)> = Vec::with_capacity(n);
        for i in 0..n {
            pairs.push((nums[i], cost[i]));
        }

        // Sort pairs by nums[i] to find the weighted median efficiently.
        pairs.sort_unstable_by_key(|p| p.0);

        // Calculate the total sum of costs.
        let mut total_cost_sum: i64 = 0;
        for &(_, c) in &pairs {
            total_cost_sum += c as i64;
        }

        // Find the weighted median. The optimal target value will be one of the nums[i] values.
        // Specifically, it's the value x such that the sum of costs for elements <= x is at least
        // half of the total cost sum, and the sum of costs for elements < x is less than half.
        let mut current_cost_sum: i64 = 0;
        let mut median_num: i32 = 0;

        for &(num, c) in &pairs {
            current_cost_sum += c as i64;
            if current_cost_sum * 2 >= total_cost_sum {
                median_num = num;
                break;
            }
        }

        // Calculate the minimum total cost using the found median_num as the target.
        let mut final_min_cost: i64 = 0;
        for i in 0..n {
            final_min_cost += cost[i] as i64 * (nums[i] as i64 - median_num as i64).abs();
        }

        final_min_cost
    }
}