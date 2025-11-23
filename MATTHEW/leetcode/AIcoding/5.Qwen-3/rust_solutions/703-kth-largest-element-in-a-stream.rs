impl Solution {

use std::collections::BinaryHeap;

struct KthLargest {
    heap: BinaryHeap<i32>,
    k: i32,
}

impl KthLargest {
    fn new(mut nums: Vec<i32>, k: i32) -> Self {
        nums.sort_unstable_by(|a, b| b.cmp(a));
        let mut heap = BinaryHeap::new();
        for i in 0..k {
            if i < nums.len() {
                heap.push(nums[i]);
            }
        }
        KthLargest { heap, k }
    }

    fn add(&mut self, val: i32) -> i32 {
        if self.heap.len() < self.k as usize {
            self.heap.push(val);
        } else if val > *self.heap.peek().unwrap() {
            self.heap.pop();
            self.heap.push(val);
        }
        *self.heap.peek().unwrap()
    }
}
}