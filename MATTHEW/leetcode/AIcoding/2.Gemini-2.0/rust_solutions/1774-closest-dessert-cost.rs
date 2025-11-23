impl Solution {
    pub fn closest_cost(base_costs: Vec<i32>, topping_costs: Vec<i32>, target: i32) -> i32 {
        let mut closest = base_costs[0];
        for &cost in &base_costs {
            closest = Self::update_closest(closest, cost, target);
        }

        let mut dp = vec![false; 20001];
        for &cost in &base_costs {
            dp[cost as usize] = true;
        }

        for &topping in &topping_costs {
            for _ in 0..2 {
                let mut new_dp = dp.clone();
                for i in 0..20001 {
                    if dp[i] && i + topping as usize <= 20000 {
                        new_dp[i + topping as usize] = true;
                    }
                }
                dp = new_dp;
            }
        }

        for i in 0..20001 {
            if dp[i] {
                closest = Self::update_closest(closest, i as i32, target);
            }
        }

        closest
    }

    fn update_closest(closest: i32, cost: i32, target: i32) -> i32 {
        if (cost - target).abs() < (closest - target).abs() {
            cost
        } else if (cost - target).abs() == (closest - target).abs() {
            std::cmp::min(closest, cost)
        } else {
            closest
        }
    }
}