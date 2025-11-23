impl Solution {
    pub fn max_profit(inventory: Vec<i32>, orders: i32) -> i32 {
        let mut inventory = inventory;
        inventory.sort_unstable();
        let mut total_profit = 0;
        let mut prev = 0;
        let mut orders = orders;

        for &ball_count in inventory.iter().rev() {
            let current = ball_count - prev;
            let count = inventory.iter().filter(|&&x| x == ball_count).count() as i32;

            if orders <= count * current {
                let full_layers = orders / count;
                let remaining_orders = orders % count;

                total_profit += (current * (current + 1) / 2) * count - (current - full_layers) * (current - full_layers + 1) / 2 * count;
                total_profit += (current - full_layers) * remaining_orders;
                return total_profit % 1_000_000_007;
            } else {
                total_profit += (current * (current + 1) / 2) * count;
                orders -= count * current;
                prev = ball_count;
            }
        }

        total_profit += (prev * (prev + 1) / 2) * orders / inventory.len() as i32;
        total_profit % 1_000_000_007
    }
}