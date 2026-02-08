use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct MedianFinder {
    small_half: BinaryHeap<i32>,
    large_half: BinaryHeap<Reverse<i32>>,
}

impl MedianFinder {
    fn new() -> Self {
        MedianFinder {
            small_half: BinaryHeap::new(),
            large_half: BinaryHeap::new(),
        }
    }

    fn add_num(&mut self, num: i32) {
        self.small_half.push(num);

        if let Some(val) = self.small_half.pop() {
            self.large_half.push(Reverse(val));
        }

        if self.large_half.len() > self.small_half.len() {
            if let Some(Reverse(val)) = self.large_half.pop() {
                self.small_half.push(val);
            }
        }
    }

    fn find_median(&self) -> f64 {
        if self.small_half.len() > self.large_half.len() {
            *self.small_half.peek().unwrap() as f64
        } else {
            let s_top = *self.small_half.peek().unwrap() as f64;
            let l_top = self.large_half.peek().unwrap().0 as f64;
            (s_top + l_top) / 2.0
        }
    }
}