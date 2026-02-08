use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn kth_largest_number(nums: Vec<String>, k: i32) -> String {
        let mut heap = BinaryHeap::new();
        for num in nums {
            heap.push(Reverse(num));
            if heap.len() > k as usize {
                heap.pop();
            }
        }
        heap.pop().unwrap().0
    }
}