use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct SlidingWindowMedian {
    k: i32,
    lower: BinaryHeap<i32>,
    upper: BinaryHeap<Reverse<i32>>,
    removed: std::collections::HashMap<i32, i32>,
}

impl SlidingWindowMedian {
    fn new(k: i32) -> Self {
        SlidingWindowMedian {
            k,
            lower: BinaryHeap::new(),
            upper: BinaryHeap::new(),
            removed: std::collections::HashMap::new(),
        }
    }

    fn add(&mut self, num: i32) {
        if self.lower.is_empty() || num <= *self.lower.peek().unwrap() {
            self.lower.push(num);
        } else {
            self.upper.push(Reverse(num));
        }
        self.rebalance();
    }

    fn remove(&mut self, num: i32) {
        *self.removed.entry(num).or_insert(0) += 1;
        self.rebalance();
    }

    fn rebalance(&mut self) {
        while self.lower.len() > (self.k as usize + 1) / 2 {
            self.upper.push(Reverse(self.lower.pop().unwrap()));
        }
        while self.upper.len() > self.k as usize / 2 {
            self.lower.push(self.upper.pop().unwrap().0);
        }

        while let Some(&top) = self.lower.peek() {
            if let Some(&count) = self.removed.get(&top) {
                if count > 0 {
                    self.lower.pop();
                    self.removed.insert(top, count - 1);
                } else {
                    break;
                }
            } else {
                break;
            }
        }

        while let Some(&Reverse(top)) = self.upper.peek() {
            if let Some(&count) = self.removed.get(&top) {
                if count > 0 {
                    self.upper.pop();
                    self.removed.insert(top, count - 1);
                } else {
                    break;
                }
            } else {
                break;
            }
        }
    }

    fn get_median(&self) -> f64 {
        if self.k % 2 == 0 {
            (self.lower.peek().unwrap() as f64 + self.upper.peek().unwrap().0 as f64) / 2.0
        } else {
            *self.lower.peek().unwrap() as f64
        }
    }
}

impl Solution {
    pub fn median_sliding_window(nums: Vec<i32>, k: i32) -> Vec<f64> {
        let mut swm = SlidingWindowMedian::new(k);
        let mut result = Vec::new();

        for i in 0..nums.len() {
            swm.add(nums[i]);
            if i as i32 >= k - 1 {
                result.push(swm.get_median());
                swm.remove(nums[i - k as usize + 1]);
            }
        }

        result
    }
}