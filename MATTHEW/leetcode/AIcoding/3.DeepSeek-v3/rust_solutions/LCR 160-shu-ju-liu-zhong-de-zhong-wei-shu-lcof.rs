use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct MedianFinder {
    max_heap: BinaryHeap<i32>,
    min_heap: BinaryHeap<Reverse<i32>>,
}

impl MedianFinder {
    fn new() -> Self {
        MedianFinder {
            max_heap: BinaryHeap::new(),
            min_heap: BinaryHeap::new(),
        }
    }

    fn add_num(&mut self, num: i32) {
        if self.max_heap.is_empty() || num <= *self.max_heap.peek().unwrap() {
            self.max_heap.push(num);
        } else {
            self.min_heap.push(Reverse(num));
        }

        if self.max_heap.len() > self.min_heap.len() + 1 {
            if let Some(val) = self.max_heap.pop() {
                self.min_heap.push(Reverse(val));
            }
        } else if self.min_heap.len() > self.max_heap.len() {
            if let Some(Reverse(val)) = self.min_heap.pop() {
                self.max_heap.push(val);
            }
        }
    }

    fn find_median(&self) -> f64 {
        if self.max_heap.len() > self.min_heap.len() {
            *self.max_heap.peek().unwrap() as f64
        } else {
            (*self.max_heap.peek().unwrap() as f64 + self.min_heap.peek().unwrap().0 as f64) / 2.0
        }
    }
}