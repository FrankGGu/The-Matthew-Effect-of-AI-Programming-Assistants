impl Solution {
    pub fn min_cost(nums: Vec<i32>, cost: Vec<i32>) -> i64 {
        let mut nums_and_cost: Vec<_> = nums.iter().zip(cost.iter()).collect();
        nums_and_cost.sort_unstable();

        let mut prefix_cost = vec![0; nums_and_cost.len()];
        prefix_cost[0] = *nums_and_cost[0].1 as i64;
        for i in 1..nums_and_cost.len() {
            prefix_cost[i] = prefix_cost[i - 1] + *nums_and_cost[i].1 as i64;
        }

        let total_cost = prefix_cost.last().unwrap();
        let mut total = 0;
        for i in 1..nums_and_cost.len() {
            let diff = *nums_and_cost[i].0 as i64 - *nums_and_cost[0].0 as i64;
            total += diff * *nums_and_cost[i].1 as i64;
        }

        let mut answer = total;
        for i in 1..nums_and_cost.len() {
            let diff = *nums_and_cost[i].0 as i64 - *nums_and_cost[i - 1].0 as i64;
            total += diff * (2 * prefix_cost[i - 1] - total_cost);
            answer = answer.min(total);
        }

        answer
    }
}