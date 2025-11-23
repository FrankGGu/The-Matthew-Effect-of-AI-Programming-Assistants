impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct MedianFinder {
    lower: BinaryHeap<Reverse<i32>>,  // max heap
    upper: BinaryHeap<i32>,           // min heap
}

impl MedianFinder {
    fn new() -> Self {
        MedianFinder {
            lower: BinaryHeap::new(),
            upper: BinaryHeap::new(),
        }
    }

    fn add_num(&mut self, num: i32) {
        if self.lower.is_empty() || num <= *self.lower.peek().unwrap().0 {
            self.lower.push(Reverse(num));
        } else {
            self.upper.push(num);
        }

        // Balance the heaps
        if self.lower.len() > self.upper.len() + 1 {
            self.upper.push(self.lower.pop().unwrap().0);
        } else if self.upper.len() > self.lower.len() {
            self.lower.push(Reverse(self.upper.pop().unwrap()));
        }
    }

    fn find_median(&self) -> f64 {
        if self.lower.len() == self.upper.len() {
            (self.lower.peek().unwrap().0 as f64 + self.upper.peek().unwrap().0 as f64) / 2.0
        } else {
            self.lower.peek().unwrap().0 as f64
        }
    }
}

fn main() {
    let mut mf = MedianFinder::new();
    mf.add_num(1);
    mf.add_num(2);
    println!("{}", mf.find_median()); // 1.5
    mf.add_num(3);
    println!("{}", mf.find_median()); // 2
}
}