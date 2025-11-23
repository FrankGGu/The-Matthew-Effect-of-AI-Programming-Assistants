use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct MedianFinder {
    max_heap_lower_half: BinaryHeap<i32>,
    min_heap_upper_half: BinaryHeap<Reverse<i32>>,
}

impl MedianFinder {
    fn new() -> Self {
        MedianFinder {
            max_heap_lower_half: BinaryHeap::new(),
            min_heap_upper_half: BinaryHeap::new(),
        }
    }

    fn add_num(&mut self, num: i32) {
        self.max_heap_lower_half.push(num);

        let val_to_move = self.max_heap_lower_half.pop().unwrap();
        self.min_heap_upper_half.push(Reverse(val_to_move));

        if self.max_heap_lower_half.len() < self.min_heap_upper_half.len() {
            let val_to_move_back = self.min_heap_upper_half.pop().unwrap().0;
            self.max_heap_lower_half.push(val_to_move_back);
        }
    }

    fn find_median(&self) -> f64 {
        if self.max_heap_lower_half.len() > self.min_heap_upper_half.len() {
            *self.max_heap_lower_half.peek().unwrap() as f64
        } else {
            let lower_median = *self.max_heap_lower_half.peek().unwrap() as f64;
            let upper_median = self.min_heap_upper_half.peek().unwrap().0 as f64;
            (lower_median + upper_median) / 2.0
        }
    }
}