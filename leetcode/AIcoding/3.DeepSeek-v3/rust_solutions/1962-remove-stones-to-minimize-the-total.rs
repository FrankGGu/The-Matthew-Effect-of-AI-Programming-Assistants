use std::collections::BinaryHeap;

impl Solution {
    pub fn min_stone_sum(piles: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for &pile in &piles {
            heap.push(pile);
        }
        for _ in 0..k {
            if let Some(max) = heap.pop() {
                let removed = max / 2;
                heap.push(max - removed);
            }
        }
        heap.iter().sum()
    }
}