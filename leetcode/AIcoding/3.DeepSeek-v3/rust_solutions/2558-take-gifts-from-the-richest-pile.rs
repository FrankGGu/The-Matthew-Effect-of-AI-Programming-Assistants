use std::collections::BinaryHeap;

impl Solution {
    pub fn pick_gifts(gifts: Vec<i32>, k: i32) -> i64 {
        let mut heap = BinaryHeap::from(gifts);
        for _ in 0..k {
            if let Some(max) = heap.pop() {
                let remaining = (max as f64).sqrt().floor() as i32;
                heap.push(remaining);
            }
        }
        heap.into_iter().map(|x| x as i64).sum()
    }
}