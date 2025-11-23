impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct Solution;

impl Solution {
    pub fn sell_diminishing_valued_colored_balls(quantity: Vec<i32>, price: Vec<i32>) -> i64 {
        let mut max_heap = BinaryHeap::new();
        for (i, &q) in quantity.iter().enumerate() {
            if q > 0 {
                max_heap.push(Reverse((price[i] as i64, q as i64)));
            }
        }

        let mut total = 0;
        while let Some(Reverse((p, mut q))) = max_heap.pop() {
            let count = q.min(100);
            total += p * count;
            if q > 100 {
                max_heap.push(Reverse((p - 1, q - 100)));
            }
        }

        total
    }
}
}