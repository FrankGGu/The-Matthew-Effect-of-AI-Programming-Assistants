impl Solution {
    pub fn min_cost(nums: Vec<i32>, x: i32) -> i64 {
        let n = nums.len();
        let mut min_costs = nums.iter().map(|&num| num as i64).collect::<Vec<_>>();
        let mut res = min_costs.iter().sum();

        for shift in 1..n {
            let mut current_cost = (shift as i64) * (x as i64);
            for i in 0..n {
                let new_cost = nums[(i + shift) % n] as i64;
                if new_cost < min_costs[i] {
                    min_costs[i] = new_cost;
                }
                current_cost += min_costs[i];
            }
            if current_cost < res {
                res = current_cost;
            }
        }

        res
    }
}