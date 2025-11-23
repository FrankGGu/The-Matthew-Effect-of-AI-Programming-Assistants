impl Solution {
    pub fn minimum_cost(s: String, cost: Vec<i32>) -> i32 {
        let mut total_cost = 0;
        let mut max_cost = 0;

        for (i, c) in s.chars().enumerate() {
            if i > 0 && s.chars().nth(i - 1) == Some(c) {
                total_cost += cost[i];
                max_cost = max_cost.max(cost[i - 1]);
            } else {
                if max_cost > 0 {
                    total_cost -= max_cost;
                }
                max_cost = cost[i];
            }
        }

        if max_cost > 0 {
            total_cost -= max_cost;
        }

        total_cost
    }
}