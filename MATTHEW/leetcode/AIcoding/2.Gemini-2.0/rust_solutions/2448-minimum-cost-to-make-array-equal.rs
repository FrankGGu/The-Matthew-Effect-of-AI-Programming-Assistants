impl Solution {
    pub fn min_cost(nums: Vec<i32>, cost: Vec<i32>) -> i64 {
        let mut nums_cost: Vec<(i32, i32)> = nums.into_iter().zip(cost.into_iter()).collect();
        nums_cost.sort();

        let mut total_cost: i64 = nums_cost.iter().map(|&(_, c)| c as i64).sum();
        let mut prefix_cost: i64 = 0;

        let mut median: i32 = 0;
        for &(num, cost) in &nums_cost {
            prefix_cost += cost as i64;
            if prefix_cost * 2 >= total_cost {
                median = num;
                break;
            }
        }

        let mut result: i64 = 0;
        for &(num, cost) in &nums_cost {
            result += (num as i64 - median as i64).abs() * cost as i64;
        }

        result
    }
}