use std::collections::BinaryHeap;
use std::cmp::{min, Reverse};

impl Solution {
    pub fn get_number_of_backlog_orders(orders: Vec<Vec<i32>>) -> i32 {
        // Max-heap for buy orders: (price, quantity). Orders by price descending.
        let mut buy_orders: BinaryHeap<(i32, i32)> = BinaryHeap::new(); 
        // Min-heap for sell orders: Reverse((price, quantity)). Orders by price ascending.
        let mut sell_orders: BinaryHeap<Reverse<(i32, i32)>> = BinaryHeap::new(); 

        let modulus: i64 = 1_000_000_007;

        for order in orders {
            let price = order[0];
            let mut amount = order[1];
            let order_type = order[2]; // 0 for buy, 1 for sell

            if order_type == 0 { // Buy order
                // Try to match with existing sell orders
                while amount > 0 && !sell_orders.is_empty() {
                    let Reverse((sell_price, sell_quantity)) = *sell_orders.peek().unwrap();

                    // A buy order can match a sell order if its price is >= sell_price
                    if sell_price <= price {
                        sell_orders.pop(); // Remove the top (lowest price) sell order

                        let matched_amount = min(amount, sell_quantity);
                        amount -= matched_amount;
                        let remaining_sell_quantity = sell_quantity - matched_amount;

                        // If there's remaining quantity in the sell order, push it back
                        if remaining_sell_quantity > 0 {
                            sell_orders.push(Reverse((sell_price, remaining_sell_quantity)));
                        }
                    } else {
                        // Current buy order cannot match any more sell orders (they are too expensive)
                        break; 
                    }
                }
                // If there's remaining quantity in the buy order, add it to the buy backlog
                if amount > 0 {
                    buy_orders.push((price, amount));
                }
            } else { // Sell order
                // Try to match with existing buy orders
                while amount > 0 && !buy_orders.is_empty() {
                    let (buy_price, buy_quantity) = *buy_orders.peek().unwrap();

                    // A sell order can match a buy order if its price is <= buy_price
                    if buy_price >= price {
                        buy_orders.pop(); // Remove the top (highest price) buy order

                        let matched_amount = min(amount, buy_quantity);
                        amount -= matched_amount;
                        let remaining_buy_quantity = buy_quantity - matched_amount;

                        // If there's remaining quantity in the buy order, push it back
                        if remaining_buy_quantity > 0 {
                            buy_orders.push((buy_price, remaining_buy_quantity));
                        }
                    } else {
                        // Current sell order cannot match any more buy orders (they are too cheap)
                        break;
                    }
                }
                // If there's remaining quantity in the sell order, add it to the sell backlog
                if amount > 0 {
                    sell_orders.push(Reverse((price, amount)));
                }
            }
        }

        let mut total_backlog: i64 = 0;

        // Sum quantities from buy backlog
        for (_price, quantity) in buy_orders.into_iter() {
            total_backlog = (total_backlog + quantity as i64) % modulus;
        }

        // Sum quantities from sell backlog
        for Reverse((_price, quantity)) in sell_orders.into_iter() {
            total_backlog = (total_backlog + quantity as i64) % modulus;
        }

        total_backlog as i32
    }
}