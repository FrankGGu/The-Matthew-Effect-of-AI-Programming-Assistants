impl Solution {
    pub fn two_city_sched_cost(mut costs: Vec<Vec<i32>>) -> i32 {
        costs.sort_unstable_by(|a, b| {
            let diff_a = a[0] - a[1];
            let diff_b = b[0] - b[1];
            diff_a.cmp(&diff_b)
        });

        let n = costs.len() / 2;
        let mut total_cost = 0;

        for i in 0..n {
            total_cost += costs[i][0];
        }

        for i in n..costs.len() {
            total_cost += costs[i][1];
        }

        total_cost
    }
}