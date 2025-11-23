use std::collections::BinaryHeap;

impl Solution {
    pub fn max_profit(inventory: Vec<i32>, orders: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for &num in &inventory {
            heap.push(num);
        }
        let mut orders = orders;
        let mut res: i64 = 0;
        let modulo = 1_000_000_007;

        while orders > 0 {
            let max = heap.pop().unwrap();
            let next_max = *heap.peek().unwrap_or(&0);
            let diff = max - next_max;
            let count = (heap.len() + 1) as i32;
            let mut sell = diff.min(orders / count);
            if sell == 0 {
                sell = 1;
            }
            let sell = sell.min(orders);
            let current = max - sell + 1;
            let sum = (max as i64 + current as i64) * sell as i64 / 2;
            res = (res + sum * count as i64) % modulo;
            orders -= sell * count;
            heap.push(max - sell);
        }

        res as i32
    }
}