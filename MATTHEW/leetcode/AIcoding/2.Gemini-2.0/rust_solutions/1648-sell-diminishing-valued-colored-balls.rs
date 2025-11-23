impl Solution {
    pub fn max_profit(inventory: Vec<i32>, orders: i32) -> i32 {
        let mut inventory = inventory;
        inventory.sort_unstable();
        let mut inventory = inventory;
        inventory.reverse();

        let mut ans: i64 = 0;
        let mut orders_left = orders as i64;
        let mut i = 0;

        while orders_left > 0 {
            let next_val = if i + 1 < inventory.len() {
                inventory[i + 1]
            } else {
                0
            };

            let diff = inventory[i] as i64 - next_val as i64;
            let num_balls = (i + 1) as i64;

            if diff * num_balls <= orders_left {
                let start = inventory[i] as i64;
                let end = next_val as i64 + 1;
                let sum = (start + end) * diff / 2;
                ans = (ans + sum * num_balls) % 1000000007;
                orders_left -= diff * num_balls;
            } else {
                let num_levels = orders_left / num_balls;
                let start = inventory[i] as i64;
                let end = inventory[i] as i64 - num_levels + 1;
                let sum = (start + end) * num_levels / 2;
                ans = (ans + sum * num_balls) % 1000000007;
                orders_left -= num_levels * num_balls;

                let remaining = orders_left;
                ans = (ans + inventory[i] as i64 * remaining) % 1000000007;
                orders_left = 0;
            }

            i += 1;
        }

        ans as i32
    }
}