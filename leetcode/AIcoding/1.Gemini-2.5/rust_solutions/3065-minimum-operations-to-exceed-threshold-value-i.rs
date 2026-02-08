use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for num in nums {
            heap.push(Reverse(num));
        }

        let mut operations = 0;
        while heap.len() >= 2 && heap.peek().unwrap().0 < k {
            let x = heap.pop().unwrap().0;
            let y = heap.pop().unwrap().0;
            heap.push(Reverse(x + y));
            operations += 1;
        }

        operations
    }
}