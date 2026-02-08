impl Solution {
    pub fn minimum_cost(mut cost: Vec<i32>) -> i32 {
        cost.sort_unstable();
        let mut total_cost = 0;
        let n = cost.len();
        for i in (0..n).rev().step_by(3) {
            total_cost += cost[i];
            if i > 0 {
                total_cost += cost[i - 1];
            }
        }
        total_cost
    }
}