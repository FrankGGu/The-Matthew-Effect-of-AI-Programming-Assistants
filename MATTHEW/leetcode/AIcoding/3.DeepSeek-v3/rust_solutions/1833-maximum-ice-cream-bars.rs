impl Solution {
    pub fn max_ice_cream(costs: Vec<i32>, coins: i32) -> i32 {
        let mut costs = costs;
        costs.sort_unstable();
        let mut remaining = coins;
        let mut count = 0;
        for cost in costs {
            if remaining >= cost {
                remaining -= cost;
                count += 1;
            } else {
                break;
            }
        }
        count
    }
}