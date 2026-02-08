use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn get_number_of_backlog_orders(orders: Vec<Vec<i32>>) -> i32 {
        let mut buy_orders: BinaryHeap<(i32, i32)> = BinaryHeap::new();
        let mut sell_orders: BinaryHeap<(Reverse<i32>, i32)> = BinaryHeap::new();

        for order in orders {
            let price = order[0];
            let amount = order[1];
            let order_type = order[2];

            if order_type == 0 {
                // Buy order
                let mut remaining_amount = amount;
                while remaining_amount > 0 && !sell_orders.is_empty() && sell_orders.peek().unwrap().0.0 <= price {
                    let (Reverse(sell_price), sell_amount) = sell_orders.pop().unwrap();
                    if sell_amount <= remaining_amount {
                        remaining_amount -= sell_amount;
                    } else {
                        sell_orders.push((Reverse(sell_price), sell_amount - remaining_amount));
                        remaining_amount = 0;
                    }
                }
                if remaining_amount > 0 {
                    buy_orders.push((price, remaining_amount));
                }
            } else {
                // Sell order
                let mut remaining_amount = amount;
                while remaining_amount > 0 && !buy_orders.is_empty() && buy_orders.peek().unwrap().0 >= price {
                    let (buy_price, buy_amount) = buy_orders.pop().unwrap();
                    if buy_amount <= remaining_amount {
                        remaining_amount -= buy_amount;
                    } else {
                        buy_orders.push((buy_price, buy_amount - remaining_amount));
                        remaining_amount = 0;
                    }
                }
                if remaining_amount > 0 {
                    sell_orders.push((Reverse(price), remaining_amount));
                }
            }
        }

        let mut total_orders: i64 = 0;
        for (_, amount) in buy_orders {
            total_orders += amount as i64;
        }
        for (_, amount) in sell_orders {
            total_orders += amount as i64;
        }

        (total_orders % 1000000007) as i32
    }
}