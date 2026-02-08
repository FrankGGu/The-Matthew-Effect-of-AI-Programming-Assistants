use std::collections::BinaryHeap;

struct KthLargest {
    heap: BinaryHeap<i32>,
    k: usize,
}

impl KthLargest {
    fn new(k: i32, nums: Vec<i32>) -> Self {
        let mut heap = BinaryHeap::new();
        for num in nums {
            heap.push(num);
        }
        let k = k as usize;
        while heap.len() > k {
            heap.pop();
        }
        KthLargest { heap, k }
    }

    fn add(&mut self, val: i32) -> i32 {
        self.heap.push(val);
        if self.heap.len() > self.k {
            self.heap.pop();
        }
        *self.heap.peek().unwrap()
    }
}