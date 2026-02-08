impl Solution {
    pub fn min_increments(n: i32, cost: Vec<i32>, target: Vec<i32>) -> i32 {
        let mut increments = 0;
        let mut total_cost = vec![0; n as usize + 1];

        for i in 0..cost.len() {
            total_cost[target[i] as usize] += cost[i];
        }

        for i in 1..=n {
            increments += total_cost[i as usize].max(0);
        }

        increments
    }
}