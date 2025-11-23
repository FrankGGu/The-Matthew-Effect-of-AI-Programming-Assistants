use std::collections::{BinaryHeap, HashMap};
use std::cmp::Reverse;

struct MedianFinder {
    left_heap: BinaryHeap<i32>, // Max-heap for the smaller half of numbers
    right_heap: BinaryHeap<Reverse<i32>>, // Min-heap for the larger half of numbers
    removed_counts: HashMap<i32, i32>, // Counts of numbers marked for lazy removal
}

impl MedianFinder {
    fn new() -> Self {
        MedianFinder {
            left_heap: BinaryHeap::new(),
            right_heap: BinaryHeap::new(),
            removed_counts: HashMap::new(),
        }
    }

    fn clean_left_heap(&mut self) {
        while let Some(&top) = self.left_heap.peek() {
            if let Some(count) = self.removed_counts.get_mut(&top) {
                if *count > 0 {
                    self.left_heap.pop();
                    *count -= 1;
                    continue;
                }
            }
            break;
        }
    }

    fn clean_right_heap(&mut self) {
        while let Some(Reverse(top)) = self.right_heap.peek() {
            if let Some(count) = self.removed_counts.get_mut(top) {
                if *count > 0 {
                    self.right_heap.pop();
                    *count -= 1;
                    continue;
                }
            }
            break;
        }
    }

    fn rebalance(&mut self) {
        self.clean_left_heap();
        self.clean_right_heap();

        if let (Some(&left_max), Some(Reverse(right_min))) = (self.left_heap.peek(), self.right_heap.peek()) {
            if left_max > *right_min {
                let l_val = self.left_heap.pop().unwrap();
                let r_val = self.right_heap.pop().unwrap().0;
                self.left_heap.push(r_val);
                self.right_heap.push(Reverse(l_val));
            }
        }

        self.clean_left_heap();
        self.clean_right_heap();

        if self.left_heap.len() > self.right_heap.len() + 1 {
            if let Some(val) = self.left_heap.pop() {
                self.right_heap.push(Reverse(val));
            }
        } else if self.right_heap.len() > self.left_heap.len() {
            if let Some(Reverse(val)) = self.right_heap.pop() {
                self.left_heap.push(val);
            }
        }
    }

    fn add_num(&mut self, num: i32) {
        self.left_heap.push(num);
        self.rebalance();
    }

    fn remove_num(&mut self, num: i32) {
        *self.removed_counts.entry(num).or_insert(0) += 1;
        self.rebalance();
    }

    fn find_median(&mut self) -> f64 {
        self.clean_left_heap();
        self.clean_right_heap();

        if self.left_heap.len() == self.right_heap.len() {
            let l = *self.left_heap.peek().unwrap() as f64;
            let r = self.right_heap.peek().unwrap().0 as f64;
            (l + r) / 2.0
        } else {
            *self.left_heap.peek().unwrap() as f64
        }
    }
}

struct Solution;

impl Solution {
    pub fn median_sliding_window(nums: Vec<i32>, k: i32) -> Vec<f64> {
        let k_usize = k as usize;
        let mut mf = MedianFinder::new();
        let mut result = Vec::new();

        for i in 0..nums.len() {
            mf.add_num(nums[i]);

            if i >= k_usize - 1 {
                result.push(mf.find_median());
                mf.remove_num(nums[i - (k_usize - 1)]);
            }
        }
        result
    }
}