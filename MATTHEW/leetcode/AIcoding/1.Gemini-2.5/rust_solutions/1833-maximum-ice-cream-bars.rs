impl Solution {
    pub fn max_ice_cream(mut costs: Vec<i32>, mut coins: i32) -> i32 {
        costs.sort_unstable();
        let mut bought_bars = 0;
        for cost in costs {
            if coins >= cost {
                coins -= cost;
                bought_bars += 1;
            } else {
                break;
            }
        }
        bought_bars
    }
}