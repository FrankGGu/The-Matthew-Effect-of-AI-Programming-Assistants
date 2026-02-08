pub fn max_ice_cream(costs: Vec<i32>, coins: i32) -> i32 {
    let mut costs = costs;
    costs.sort();
    let mut count = 0;
    let mut total = 0;

    for cost in costs {
        if total + cost <= coins {
            total += cost;
            count += 1;
        } else {
            break;
        }
    }

    count
}