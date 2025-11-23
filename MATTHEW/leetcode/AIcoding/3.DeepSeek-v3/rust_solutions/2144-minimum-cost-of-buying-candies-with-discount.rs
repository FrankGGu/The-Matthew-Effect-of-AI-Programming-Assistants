impl Solution {
    pub fn minimum_cost(cost: Vec<i32>) -> i32 {
        let mut cost = cost;
        cost.sort_unstable_by(|a, b| b.cmp(a));
        let mut total = 0;
        for i in 0..cost.len() {
            if i % 3 != 2 {
                total += cost[i];
            }
        }
        total
    }
}