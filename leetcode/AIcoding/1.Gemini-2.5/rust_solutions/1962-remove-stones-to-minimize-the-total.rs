use std::collections::BinaryHeap;

impl Solution {
    pub fn min_stone_sum(piles: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for pile in piles {
            heap.push(pile);
        }

        for _ in 0..k {
            if let Some(mut max_pile) = heap.pop() {
                max_pile -= max_pile / 2;
                heap.push(max_pile);
            } else {
                break; 
            }
        }

        heap.iter().sum()
    }
}