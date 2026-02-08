impl Solution {
    pub fn max_profit(customers: Vec<i32>, boarding_cost: i32, running_cost: i32) -> i32 {
        let mut max_profit = i32::MIN;
        let mut min_rotations_at_max_profit = -1;

        let mut total_customers_waiting = 0;
        let mut total_customers_boarded = 0;
        let mut rotations = 0;

        let num_customer_arrivals = customers.len() as i32;

        loop {
            if rotations < num_customer_arrivals {
                total_customers_waiting += customers[rotations as usize];
            }

            if total_customers_waiting == 0 && rotations >= num_customer_arrivals {
                break;
            }

            let customers_to_board = std::cmp::min(total_customers_waiting, 4);
            total_customers_boarded += customers_to_board;
            total_customers_waiting -= customers_to_board;

            rotations += 1;

            let current_profit = (total_customers_boarded * boarding_cost) - (rotations * running_cost);

            if current_profit > max_profit {
                max_profit = current_profit;
                min_rotations_at_max_profit = rotations;
            }
        }

        if max_profit < 0 {
            -1
        } else {
            min_rotations_at_max_profit
        }
    }
}