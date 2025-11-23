impl Solution {

use std::collections::BinaryHeap;

#[derive(PartialEq, Eq, PartialOrd, Ord)]
struct MaxHeap(i32);

impl Solution {
    pub fn last_stone_weight(stones: Vec<i32>) -> i32 {
        let mut heap = BinaryHeap::new();

        for stone in stones {
            heap.push(MaxHeap(stone));
        }

        while heap.len() > 1 {
            let mut a = heap.pop().unwrap();
            let mut b = heap.pop().unwrap();

            if a.0 != b.0 {
                let new_stone = a.0 - b.0;
                heap.push(MaxHeap(new_stone));
            }
        }

        match heap.pop() {
            Some(MaxHeap(weight)) => weight,
            None => 0,
        }
    }
}
}