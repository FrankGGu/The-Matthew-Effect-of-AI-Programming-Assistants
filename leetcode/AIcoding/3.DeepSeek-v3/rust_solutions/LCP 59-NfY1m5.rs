use std::collections::BinaryHeap;

impl Solution {
    pub fn cross_river(stones: Vec<i32>) -> i32 {
        let mut max_heap = BinaryHeap::new();
        for &stone in stones.iter() {
            max_heap.push(stone);
        }

        while let Some(first) = max_heap.pop() {
            if max_heap.is_empty() {
                return first;
            }
            let second = max_heap.pop().unwrap();
            if first != second {
                max_heap.push(first - second);
            }
        }

        0
    }
}