use std::collections::BinaryHeap;

#[derive(Eq, PartialEq)]
struct Order {
    price: i32,
    amount: i32,
    is_buy: bool,
}

impl Ord for Order {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        if self.is_buy {
            other.price.cmp(&self.price)
        } else {
            self.price.cmp(&other.price)
        }
    }
}

impl PartialOrd for Order {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn get_number_of_backlog_orders(orders: Vec<Vec<i32>>) -> i32 {
        let mut buy_heap: BinaryHeap<Order> = BinaryHeap::new();
        let mut sell_heap: BinaryHeap<Order> = BinaryHeap::new();

        for order in orders {
            let price = order[0];
            let amount = order[1];
            let is_buy = order[2] == 0;

            if is_buy {
                let mut remaining = amount;
                while remaining > 0 && !sell_heap.is_empty() && sell_heap.peek().unwrap().price <= price {
                    let mut sell_order = sell_heap.pop().unwrap();
                    let matched = std::cmp::min(remaining, sell_order.amount);
                    remaining -= matched;
                    sell_order.amount -= matched;
                    if sell_order.amount > 0 {
                        sell_heap.push(sell_order);
                    }
                }
                if remaining > 0 {
                    buy_heap.push(Order { price, amount: remaining, is_buy: true });
                }
            } else {
                let mut remaining = amount;
                while remaining > 0 && !buy_heap.is_empty() && buy_heap.peek().unwrap().price >= price {
                    let mut buy_order = buy_heap.pop().unwrap();
                    let matched = std::cmp::min(remaining, buy_order.amount);
                    remaining -= matched;
                    buy_order.amount -= matched;
                    if buy_order.amount > 0 {
                        buy_heap.push(buy_order);
                    }
                }
                if remaining > 0 {
                    sell_heap.push(Order { price, amount: remaining, is_buy: false });
                }
            }
        }

        let mut total = 0;
        for order in buy_heap.into_iter().chain(sell_heap.into_iter()) {
            total = (total + order.amount) % 1_000_000_007;
        }
        total
    }
}