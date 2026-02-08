use std::collections::BinaryHeap;

pub fn get_number_of_backlogged_orders(orders: Vec<Vec<i32>>) -> i32 {
    const MOD: i32 = 1_000_000_007;
    let mut buy_heap = BinaryHeap::new();
    let mut sell_heap = BinaryHeap::new();

    for order in orders {
        let (price, amount, order_type) = (order[0], order[1], order[2]);
        if order_type == 0 {
            buy_heap.push((price, amount));
        } else {
            sell_heap.push((-price, amount));
        }

        while let Some(&(bp, bm)) = buy_heap.peek() {
            if let Some(&(sp, sm)) = sell_heap.peek() {
                if bp >= -sp {
                    let trade_amount = bm.min(-sm);
                    buy_heap.pop();
                    sell_heap.pop();
                    if bm > trade_amount {
                        buy_heap.push((bp, bm - trade_amount));
                    }
                    if -sm > trade_amount {
                        sell_heap.push((sp, sm - trade_amount));
                    }
                } else {
                    break;
                }
            } else {
                break;
            }
        }
    }

    let mut result = 0;
    for &(price, amount) in buy_heap.iter() {
        result = (result + amount) % MOD;
    }
    for &(-price, amount) in sell_heap.iter() {
        result = (result + amount) % MOD;
    }
    result
}