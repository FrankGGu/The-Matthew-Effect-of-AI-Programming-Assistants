use std::collections::BinaryHeap;

struct MedianFinder {
    max_heap: BinaryHeap<i32>,
    min_heap: BinaryHeap<i32>,
}

impl MedianFinder {
    fn new() -> Self {
        MedianFinder {
            max_heap: BinaryHeap::new(),
            min_heap: BinaryHeap::new(),
        }
    }

    fn add_num(&mut self, num: i32) {
        self.max_heap.push(-num);
        if let Some(&top) = self.max_heap.peek() {
            self.min_heap.push(-top);
        }
        if self.min_heap.len() > self.max_heap.len() + 1 {
            if let Some(top) = self.min_heap.pop() {
                self.max_heap.push(-top);
            }
        }
        if self.max_heap.len() > self.min_heap.len() {
            if let Some(top) = self.max_heap.pop() {
                self.min_heap.push(-top);
            }
        }
    }

    fn find_median(&self) -> f64 {
        if self.min_heap.len() > self.max_heap.len() {
            return self.min_heap.peek().cloned().unwrap() as f64;
        }
        let sum = self.min_heap.peek().cloned().unwrap() + -self.max_heap.peek().cloned().unwrap();
        sum as f64 / 2.0
    }
}