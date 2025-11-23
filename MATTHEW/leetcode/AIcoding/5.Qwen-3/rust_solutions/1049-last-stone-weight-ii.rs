impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn last_stone_weight_ii(mut stones: Vec<i32>) -> i32 {
        let mut max_heap: BinaryHeap<Reverse<i32>> = stones.into_iter().map(Reverse).collect();

        while max_heap.len() > 1 {
            let a = max_heap.pop().unwrap().0;
            let b = max_heap.pop().unwrap().0;
            let diff = (a - b).abs();
            max_heap.push(Reverse(diff));
        }

        max_heap.pop().unwrap().0
    }
}
}