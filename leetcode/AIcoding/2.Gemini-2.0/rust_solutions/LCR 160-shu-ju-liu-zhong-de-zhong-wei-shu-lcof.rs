use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct MedianFinder {
    min_heap: BinaryHeap<i32>,
    max_heap: BinaryHeap<Reverse<i32>>,
}

impl MedianFinder {
    fn new() -> Self {
        MedianFinder {
            min_heap: BinaryHeap::new(),
            max_heap: BinaryHeap::new(),
        }
    }

    fn add_num(&mut self, num: i32) {
        if self.max_heap.is_empty() || num <= self.max_heap.peek().unwrap().0 {
            self.max_heap.push(Reverse(num));
        } else {
            self.min_heap.push(num);
        }

        if self.max_heap.len() > self.min_heap.len() + 1 {
            let val = self.max_heap.pop().unwrap().0;
            self.min_heap.push(val);
        } else if self.min_heap.len() > self.max_heap.len() {
            let val = self.min_heap.pop().unwrap();
            self.max_heap.push(Reverse(val));
        }
    }

    fn find_median(&self) -> f64 {
        if self.max_heap.len() == self.min_heap.len() {
            (self.max_heap.peek().unwrap().0 as f64 + self.min_heap.peek().unwrap() as f64) / 2.0
        } else {
            self.max_heap.peek().unwrap().0 as f64
        }
    }
}