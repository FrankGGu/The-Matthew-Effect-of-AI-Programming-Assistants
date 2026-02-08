use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn find_kth_largest(nums: Vec<i32>, k: i32) -> i32 {
        let mut min_heap = BinaryHeap::new();

        for num in nums {
            min_heap.push(Reverse(num));
            if min_heap.len() > k as usize {
                min_heap.pop();
            }
        }

        min_heap.pop().unwrap().0
    }
}