pub fn closest_cost(base: Vec<i32>, topping: Vec<i32>, target: i32) -> i32 {
    let mut closest = i32::MAX;
    let mut min_diff = i32::MAX;

    fn dfs(base: &Vec<i32>, topping: &Vec<i32>, index: usize, current_cost: i32, target: i32, closest: &mut i32, min_diff: &mut i32) {
        if index == topping.len() {
            let diff = (current_cost - target).abs();
            if diff < *min_diff || (diff == *min_diff && current_cost < *closest) {
                *min_diff = diff;
                *closest = current_cost;
            }
            return;
        }
        dfs(base, topping, index + 1, current_cost, target, closest, min_diff);
        dfs(base, topping, index + 1, current_cost + topping[index], target, closest, min_diff);
        dfs(base, topping, index + 1, current_cost + 2 * topping[index], target, closest, min_diff);
    }

    for b in &base {
        dfs(&base, &topping, 0, *b, target, &mut closest, &mut min_diff);
    }
    closest
}