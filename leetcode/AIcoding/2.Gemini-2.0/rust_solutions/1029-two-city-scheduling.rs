impl Solution {
    pub fn two_city_sched_cost(costs: Vec<Vec<i32>>) -> i32 {
        let mut costs = costs;
        costs.sort_by(|a, b| (a[0] - a[1]).cmp(&(b[0] - b[1])));

        let n = costs.len() / 2;
        let mut total_cost = 0;

        for i in 0..n {
            total_cost += costs[i][0];
        }

        for i in n..2 * n {
            total_cost += costs[i][1];
        }

        total_cost
    }
}