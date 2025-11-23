use std::collections::BinaryHeap;

struct MedianFinder {
    left: BinaryHeap<i32>, // max heap for the lower half
    right: BinaryHeap<i32>, // min heap for the upper half
}

impl MedianFinder {
    fn new() -> Self {
        MedianFinder {
            left: BinaryHeap::new(),
            right: BinaryHeap::new(),
        }
    }

    fn add_num(&mut self, num: i32) {
        self.left.push(-num);
        if let Some(&top) = self.left.peek() {
            self.right.push(-top);
            self.left.pop();
        }
        if self.right.len() > self.left.len() + 1 {
            self.left.push(-self.right.pop().unwrap());
        }
    }

    fn find_median(&self) -> f64 {
        if self.left.len() > self.right.len() {
            return -self.left.peek().unwrap() as f64;
        }
        return (-self.left.peek().unwrap() as f64 + self.right.peek().unwrap() as f64) / 2.0;
    }
}