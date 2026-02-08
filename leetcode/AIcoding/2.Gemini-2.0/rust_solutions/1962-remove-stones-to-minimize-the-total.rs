use std::collections::BinaryHeap;

impl Solution {
    pub fn min_stone_sum(piles: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        let mut sum = 0;
        for &pile in &piles {
            heap.push(pile);
            sum += pile;
        }

        for _ in 0..k {
            if let Some(max_pile) = heap.pop() {
                let reduction = max_pile / 2;
                sum -= reduction;
                heap.push(max_pile - reduction);
            }
        }

        sum
    }
}