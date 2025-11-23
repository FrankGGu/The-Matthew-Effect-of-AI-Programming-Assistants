impl Solution {
    pub fn max_ice_cream(costs: Vec<i32>, coins: i32) -> i32 {
        let mut costs = costs;
        costs.sort();
        let mut count = 0;
        let mut remaining_coins = coins;
        for cost in costs {
            if remaining_coins >= cost {
                remaining_coins -= cost;
                count += 1;
            } else {
                break;
            }
        }
        count
    }
}