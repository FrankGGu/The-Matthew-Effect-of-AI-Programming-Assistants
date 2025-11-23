impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn pick_gifts(mut gifts: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::from(gifts);

        for _ in 0..k {
            if let Some(mut max) = heap.pop() {
                max = (max as f64).sqrt() as i32;
                heap.push(max);
            }
        }

        heap.into_iter().sum()
    }
}
}