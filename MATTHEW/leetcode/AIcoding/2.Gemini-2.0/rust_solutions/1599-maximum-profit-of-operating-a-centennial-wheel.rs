impl Solution {
    pub fn min_operations_max_profit(customers: Vec<i32>, boarding_cost: i32, running_cost: i32) -> i32 {
        let mut total_customers = 0;
        let mut waiting = 0;
        let mut profit = 0;
        let mut max_profit = 0;
        let mut ans = -1;
        let mut rotations = 0;

        for &customer in &customers {
            waiting += customer;
            let boarded = std::cmp::min(waiting, 4);
            waiting -= boarded;
            profit += boarded as i32 * boarding_cost - running_cost;
            rotations += 1;

            if profit > max_profit {
                max_profit = profit;
                ans = rotations;
            }
        }

        while waiting > 0 {
            let boarded = std::cmp::min(waiting, 4);
            waiting -= boarded;
            profit += boarded as i32 * boarding_cost - running_cost;
            rotations += 1;

            if profit > max_profit {
                max_profit = profit;
                ans = rotations;
            }
        }

        if max_profit <= 0 {
            return -1;
        }

        ans
    }
}