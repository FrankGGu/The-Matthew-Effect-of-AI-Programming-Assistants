use std::collections::HashMap;

impl Solution {
    pub fn max_profit(mut inventory: Vec<i32>, orders: i32) -> i32 {
        inventory.sort_by(|a, b| b.cmp(a));
        let mut ans = 0i64;
        let mut orders_left = orders as i64;
        let mut i = 0;
        while orders_left > 0 {
            let next_level = if i + 1 < inventory.len() { inventory[i + 1] } else { 0 };
            let height = inventory[i] - next_level;
            let width = i as i64 + 1;
            let area = height as i64 * width;
            if area <= orders_left {
                ans += (inventory[i] as i64 + next_level as i64 + 1) * height as i64 * width / 2;
                orders_left -= area;
                i += 1;
            } else {
                let num_levels = orders_left / width;
                let remainder = (orders_left % width) as i32;
                ans += (inventory[i] as i64 + inventory[i] as i64 - num_levels + 1) * num_levels * width / 2;
                ans += (inventory[i] as i64 - num_levels) * remainder as i64;
                orders_left = 0;
            }
            ans %= 1_000_000_007;
        }
        ans as i32
    }
}