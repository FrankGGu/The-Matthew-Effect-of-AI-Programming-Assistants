impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn remove_stones(mut piles: Vec<i32>, k: i32) -> i32 {
        let mut max_heap = BinaryHeap::new();
        for pile in &piles {
            max_heap.push(*pile);
        }

        for _ in 0..k {
            if let Some(mut top) = max_heap.pop() {
                top /= 2;
                max_heap.push(top);
            }
        }

        let mut total = 0;
        while let Some(pile) = max_heap.pop() {
            total += pile;
        }

        total
    }
}
}