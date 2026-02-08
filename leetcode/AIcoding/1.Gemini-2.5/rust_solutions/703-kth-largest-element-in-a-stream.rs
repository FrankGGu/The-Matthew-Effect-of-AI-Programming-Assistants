use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct KthLargest {
    k: i32,
    heap: BinaryHeap<Reverse<i32>>,
}

impl KthLargest {
    fn new(k: i32, nums: Vec<i32>) -> Self {
        let mut kth_largest = KthLargest {
            k,
            heap: BinaryHeap::new(),
        };

        for num in nums {
            kth_largest.add(num);
        }

        kth_largest
    }

    fn add(&mut self, val: i32) -> i32 {
        if self.heap.len() < self.k as usize {
            self.heap.push(Reverse(val));
        } else if val > self.heap.peek().unwrap().0 {
            self.heap.pop();
            self.heap.push(Reverse(val));
        }

        self.heap.peek().unwrap().0
    }
}