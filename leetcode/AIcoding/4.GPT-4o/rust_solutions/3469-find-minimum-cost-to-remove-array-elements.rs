impl Solution {
    pub fn min_cost(nums: Vec<i32>, cost: Vec<i32>) -> i64 {
        let mut total_cost = 0;
        let mut total_sum = 0;
        let mut min_cost = i64::MAX;
        let n = nums.len();

        let mut nums_cost: Vec<(i32, i32)> = nums.iter().zip(cost.iter()).map(|(&n, &c)| (n, c)).collect();
        nums_cost.sort();

        for &(num, c) in &nums_cost {
            total_cost += c as i64;
            total_sum += num as i64 * c as i64;
        }

        let mut cumulative_cost = 0;
        let mut last_num = nums_cost[0].0;

        for (num, c) in nums_cost {
            cumulative_cost += c as i64;
            let current_cost = total_sum - total_cost * (num as i64) + cumulative_cost * (num as i64);
            min_cost = min_cost.min(current_cost);
            total_cost -= c as i64;
        }

        min_cost
    }
}