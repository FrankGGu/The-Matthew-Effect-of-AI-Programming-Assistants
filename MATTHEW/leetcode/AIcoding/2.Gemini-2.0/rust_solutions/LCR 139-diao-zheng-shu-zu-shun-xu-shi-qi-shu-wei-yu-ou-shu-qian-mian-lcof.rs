impl Solution {
    pub fn get_number_of_backlog_orders(orders: Vec<Vec<i32>>) -> i32 {
        use std::collections::BinaryHeap;
        use std::cmp::Reverse;

        let mut buy_orders: BinaryHeap<(i32, i32)> = BinaryHeap::new();
        let mut sell_orders: BinaryHeap<Reverse<(i32, i32)>> = BinaryHeap::new();

        for order in orders {
            let price = order[0];
            let amount = order[1];
            let order_type = order[2];

            if order_type == 0 { // Buy order
                while !sell_orders.is_empty() && sell_orders.peek().unwrap().0.0 <= price && amount > 0 {
                    let mut top_sell = sell_orders.pop().unwrap().0;
                    let sell_amount = top_sell.1;
                    let sell_price = top_sell.0;

                    if amount >= sell_amount {
                        // Buy order completely fulfills sell order
                        amount -= sell_amount;
                    } else {
                        // Buy order partially fulfills sell order
                        top_sell.1 -= amount;
                        sell_orders.push(Reverse(top_sell));
                        amount = 0;
                        break;
                    }
                }

                if amount > 0 {
                    buy_orders.push((price, amount));
                }
            } else { // Sell order
                while !buy_orders.is_empty() && buy_orders.peek().unwrap().0 >= price && amount > 0 {
                    let mut top_buy = buy_orders.pop().unwrap();
                    let buy_amount = top_buy.1;
                    let buy_price = top_buy.0;

                    if amount >= buy_amount {
                        // Sell order completely fulfills buy order
                        amount -= buy_amount;
                    } else {
                        // Sell order partially fulfills buy order
                        top_buy.1 -= amount;
                        buy_orders.push(top_buy);
                        amount = 0;
                        break;
                    }
                }

                if amount > 0 {
                    sell_orders.push(Reverse((price, amount)));
                }
            }
        }

        let mut total_backlog: i64 = 0;
        for (_, amount) in buy_orders {
            total_backlog += amount as i64;
        }
        for Reverse((_, amount)) in sell_orders {
            total_backlog += amount as i64;
        }

        (total_backlog % 1000000007) as i32
    }
}