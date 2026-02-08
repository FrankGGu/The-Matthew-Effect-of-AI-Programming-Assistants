impl Solution {
    pub fn two_city_sched_cost(costs: Vec<Vec<i32>>) -> i32 {
        let n = costs.len() / 2;
        let mut costs = costs;
        costs.sort_by_key(|c| c[0] - c[1]);
        let mut total_cost = 0;
        for i in 0..n {
            total_cost += costs[i][0];
            total_cost += costs[i + n][1];
        }
        total_cost
    }
}