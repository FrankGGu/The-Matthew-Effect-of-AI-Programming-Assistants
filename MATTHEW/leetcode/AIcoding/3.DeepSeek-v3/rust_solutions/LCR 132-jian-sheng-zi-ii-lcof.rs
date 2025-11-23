use std::collections::BinaryHeap;

impl Solution {
    pub fn max_profit(piles: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for &pile in &piles {
            heap.push(pile);
        }
        let mut res = 0;
        let mut k = k;
        while k > 0 {
            if let Some(max) = heap.pop() {
                res += max;
                let new_val = max / 2;
                heap.push(new_val);
                k -= 1;
            }
        }
        res
    }
}