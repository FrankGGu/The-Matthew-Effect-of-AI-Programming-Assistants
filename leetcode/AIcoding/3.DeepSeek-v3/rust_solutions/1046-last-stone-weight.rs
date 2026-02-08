use std::collections::BinaryHeap;

impl Solution {
    pub fn last_stone_weight(stones: Vec<i32>) -> i32 {
        let mut heap = BinaryHeap::from(stones);

        while heap.len() > 1 {
            let y = heap.pop().unwrap();
            let x = heap.pop().unwrap();
            if y != x {
                heap.push(y - x);
            }
        }

        heap.pop().unwrap_or(0)
    }
}