use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct KthLargest {
    k: i32,
    heap: BinaryHeap<Reverse<i32>>,
}

impl KthLargest {
    fn new(k: i32, nums: Vec<i32>) -> Self {
        let mut heap = BinaryHeap::new();
        for &num in &nums {
            heap.push(Reverse(num));
            if heap.len() as i32 > k {
                heap.pop();
            }
        }
        KthLargest { k, heap }
    }

    fn add(&mut self, val: i32) -> i32 {
        self.heap.push(Reverse(val));
        if self.heap.len() as i32 > self.k {
            self.heap.pop();
        }
        self.heap.peek().unwrap().0.0
    }
}