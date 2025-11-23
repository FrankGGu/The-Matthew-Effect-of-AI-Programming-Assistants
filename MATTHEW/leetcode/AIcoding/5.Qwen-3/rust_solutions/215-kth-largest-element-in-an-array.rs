impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn find_kth_largest(mut nums: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();

        for num in nums.iter() {
            heap.push(*num);
        }

        let mut result = 0;
        for _ in 0..k {
            result = heap.pop().unwrap();
        }

        result
    }
}
}