impl Solution {
    pub fn closest_cost(base_costs: Vec<i32>, topping_costs: Vec<i32>, target: i32) -> i32 {
        let mut closest = i32::MAX;
        for &base in &base_costs {
            Self::dfs(&topping_costs, 0, base, target, &mut closest);
        }
        closest
    }

    fn dfs(toppings: &[i32], index: usize, current_cost: i32, target: i32, closest: &mut i32) {
        if index == toppings.len() {
            if (current_cost - target).abs() < (*closest - target).abs() {
                *closest = current_cost;
            } else if (current_cost - target).abs() == (*closest - target).abs() {
                if current_cost < *closest {
                    *closest = current_cost;
                }
            }
            return;
        }

        for count in 0..=2 {
            Self::dfs(
                toppings,
                index + 1,
                current_cost + count * toppings[index],
                target,
                closest,
            );
        }
    }
}