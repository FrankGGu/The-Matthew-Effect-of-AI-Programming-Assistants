impl Solution {
    pub fn closest_cost(base_costs: Vec<i32>, topping_costs: Vec<i32>, target: i32) -> i32 {
        let mut all_topping_sums = Vec::new();
        Self::generate_topping_sums(&topping_costs, 0, 0, &mut all_topping_sums);

        let mut min_diff = i32::MAX;
        let mut closest_cost = -1; 

        for base_cost in base_costs {
            for topping_sum in &all_topping_sums {
                let current_total_cost = base_cost + topping_sum;
                let diff = (current_total_cost - target).abs();

                if diff < min_diff {
                    min_diff = diff;
                    closest_cost = current_total_cost;
                } else if diff == min_diff {
                    if current_total_cost < closest_cost {
                        closest_cost = current_total_cost;
                    }
                }
            }
        }
        closest_cost
    }

    fn generate_topping_sums(
        topping_costs: &[i32],
        index: usize,
        current_sum: i32,
        all_topping_sums: &mut Vec<i32>,
    ) {
        if index == topping_costs.len() {
            all_topping_sums.push(current_sum);
            return;
        }

        let topping_cost = topping_costs[index];

        Self::generate_topping_sums(topping_costs, index + 1, current_sum, all_topping_sums);
        Self::generate_topping_sums(topping_costs, index + 1, current_sum + topping_cost, all_topping_sums);
        Self::generate_topping_sums(topping_costs, index + 1, current_sum + 2 * topping_cost, all_topping_sums);
    }
}