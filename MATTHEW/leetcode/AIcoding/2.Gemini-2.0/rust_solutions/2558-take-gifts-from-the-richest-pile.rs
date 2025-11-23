use std::collections::BinaryHeap;

impl Solution {
    pub fn take_gifts(gifts: Vec<i32>, k: i32) -> i64 {
        let mut heap = BinaryHeap::from(gifts);
        for _ in 0..k {
            let top = heap.pop().unwrap();
            heap.push((top as f64).sqrt().floor() as i32);
        }
        heap.into_iter().map(|x| x as i64).sum()
    }
}