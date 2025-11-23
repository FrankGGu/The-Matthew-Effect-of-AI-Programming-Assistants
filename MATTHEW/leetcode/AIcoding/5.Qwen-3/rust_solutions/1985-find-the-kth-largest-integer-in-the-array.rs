impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn kth_largest_integer(mut nums: Vec<String>, k: i32) -> String {
        let k = k as usize;
        let mut heap = BinaryHeap::new();

        for num in nums {
            heap.push(num);
        }

        for _ in 0..k - 1 {
            heap.pop();
        }

        heap.pop().unwrap()
    }
}
}