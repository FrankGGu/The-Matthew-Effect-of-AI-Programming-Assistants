impl Solution {
    pub fn min_operations_max_profit(customers: Vec<i32>, boarding_cost: i32, running_cost: i32) -> i32 {
        let mut max_profit = 0;
        let mut max_rotations = -1;
        let mut current_profit = 0;
        let mut remaining = 0;
        let mut rot = 0;

        for i in 0..customers.len() {
            remaining += customers[i];
            let board = if remaining >= 4 { 4 } else { remaining };
            remaining -= board;
            current_profit += board * boarding_cost - running_cost;
            rot += 1;
            if current_profit > max_profit {
                max_profit = current_profit;
                max_rotations = rot;
            }
        }

        while remaining > 0 {
            let board = if remaining >= 4 { 4 } else { remaining };
            remaining -= board;
            current_profit += board * boarding_cost - running_cost;
            rot += 1;
            if current_profit > max_profit {
                max_profit = current_profit;
                max_rotations = rot;
            }
        }

        if max_profit > 0 { max_rotations } else { -1 }
    }
}