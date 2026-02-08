impl Solution {
    pub fn max_profit(mut inventory: Vec<i32>, mut orders: i32) -> i32 {
        let modulo: i64 = 1_000_000_007;
        let inv2: i64 = (modulo + 1) / 2; // Modular inverse of 2 for division by 2

        inventory.sort_unstable_by(|a, b| b.cmp(a)); // Sort in descending order

        let n = inventory.len();
        let mut total_profit: i64 = 0;
        let mut i = 0; // 'i' represents the index of the current maximum value in the sorted inventory.
                       // 'i + 1' will be the count of colors that currently have the value `inventory[i]`
                       // or have been reduced to that value.

        while orders > 0 && i < n {
            let current_max_val = inventory[i] as i64;
            let num_active_colors = (i + 1) as i64; // Number of colors currently at or above `current_max_val`

            let next_distinct_val = if i + 1 < n { inventory[i + 1] as i64 } else { 0 };

            let diff = current_max_val - next_distinct_val; // How many value levels we can sell before hitting `next_distinct_val`

            // If diff is 0, it means `inventory[i] == inventory[i+1]`.
            // This means the current `current_max_val` is not truly distinct from the next one.
            // We just need to increase `i` to include this next color in `num_active_colors`
            // and find the next *truly* distinct value.
            if diff == 0 {
                i += 1;
                continue;
            }

            // Calculate total balls available to sell if we reduce all `num_active_colors`
            // from `current_max_val` down to `next_distinct_val + 1`.
            let total_available_at_levels = num_active_colors * diff;

            if orders as i64 >= total_available_at_levels {
                // We have enough orders to sell all balls down to `next_distinct_val`.
                // Calculate the sum of values for one color: `(next_distinct_val + 1)` to `current_max_val`.
                let start_val = next_distinct_val + 1;
                let end_val = current_max_val;
                let num_terms = diff; // Number of terms in the arithmetic series

                // Sum of arithmetic series: (first_term + last_term) * num_terms / 2
                let sum_one_color = (end_val % modulo + start_val % modulo) % modulo * (num_terms % modulo) % modulo;
                let sum_one_color = sum_one_color * inv2 % modulo;

                // Add this sum for all `num_active_colors`
                total_profit = (total_profit + sum_one_color * num_active_colors) % modulo;
                orders -= total_available_at_levels as i32;
                i += 1; // Move to consider the next distinct value
            } else {
                // We don't have enough orders to sell all balls down to `next_distinct_val`.
                // We need to fulfill `orders` remaining balls.
                // Distribute `orders` among `num_active_colors` sources.
                let num_full_rows = orders as i64 / num_active_colors;
                let remaining_orders_in_row = orders as i64 % num_active_colors;

                // Sell `num_full_rows` balls from each of the `num_active_colors` sources.
                // Values sold: `current_max_val`, `current_max_val - 1`, ..., `current_max_val - num_full_rows + 1`.
                let start_val_full = current_max_val - num_full_rows + 1;
                let end_val_full = current_max_val;
                let num_terms_full = num_full_rows;

                if num_terms_full > 0 { // Only add to profit if we actually sell full rows
                    let sum_full_rows_one_color = (end_val_full % modulo + start_val_full % modulo) % modulo * (num_terms_full % modulo) % modulo;
                    let sum_full_rows_one_color = sum_full_rows_one_color * inv2 % modulo;
                    total_profit = (total_profit + sum_full_rows_one_color * num_active_colors) % modulo;
                }

                // Sell `remaining_orders_in_row` balls, each with value `current_max_val - num_full_rows`.
                let remaining_val = current_max_val - num_full_rows;
                total_profit = (total_profit + remaining_val % modulo * remaining_orders_in_row % modulo) % modulo;

                orders = 0; // All orders fulfilled.
                break;
            }
        }

        total_profit as i32
    }
}