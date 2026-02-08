use std::collections::BinaryHeap;

impl Solution {
    pub fn min_stone_sum(piles: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();

        for pile in piles {
            heap.push(pile);
        }

        for _ in 0..k {
            if let Some(mut current_max) = heap.pop() {
                current_max -= current_max / 2;
                heap.push(current_max);
            } else {
                break; 
            }
        }

        heap.iter().sum()
    }
}