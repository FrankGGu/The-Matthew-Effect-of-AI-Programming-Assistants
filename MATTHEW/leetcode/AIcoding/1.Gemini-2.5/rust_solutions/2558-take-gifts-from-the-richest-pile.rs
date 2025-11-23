use std::collections::BinaryHeap;

impl Solution {
    pub fn pick_gifts(gifts: Vec<i32>, k: i32) -> i64 {
        let mut heap = BinaryHeap::new();
        for gift in gifts {
            heap.push(gift);
        }

        for _ in 0..k {
            if let Some(richest_gift) = heap.pop() {
                let new_gift = (richest_gift as f64).sqrt().floor() as i32;
                heap.push(new_gift);
            } else {
                break;
            }
        }

        let mut total_gifts: i64 = 0;
        while let Some(gift) = heap.pop() {
            total_gifts += gift as i64;
        }

        total_gifts
    }
}