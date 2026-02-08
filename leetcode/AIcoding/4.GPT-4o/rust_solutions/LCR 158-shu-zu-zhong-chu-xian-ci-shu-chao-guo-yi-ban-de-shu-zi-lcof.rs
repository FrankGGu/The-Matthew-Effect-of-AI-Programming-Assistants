pub fn get_maximum_profit(inventory: Vec<i32>, orders: i32) -> i32 {
    let mut inventory = inventory;
    inventory.sort_unstable();
    let mut total_profit = 0;
    let mut prev = 0;
    let mut remaining_orders = orders;

    for &current in inventory.iter().rev() {
        if remaining_orders == 0 {
            break;
        }
        let count = current - prev;
        let sell_amount = count * (inventory.len() - inventory.iter().position(|&x| x == current).unwrap() as i32);

        if remaining_orders >= sell_amount {
            total_profit += (current + prev + 1) * count * count / 2;
            remaining_orders -= sell_amount;
        } else {
            let full_boxes = remaining_orders / (inventory.len() - inventory.iter().position(|&x| x == current).unwrap() as i32);
            let remainder = remaining_orders % (inventory.len() - inventory.iter().position(|&x| x == current).unwrap() as i32);
            total_profit += (current + prev) * full_boxes * full_boxes / 2;
            total_profit += (current + prev) * remainder;
            total_profit += (remainder * (remainder + 1)) / 2;
            remaining_orders = 0;
        }
        prev = current;
    }

    total_profit % 1_000_000_007
}