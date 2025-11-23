use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct MedianFinder {
    small: BinaryHeap<i32>,
    large: BinaryHeap<Reverse<i32>>,
}

impl MedianFinder {
    fn new() -> Self {
        MedianFinder {
            small: BinaryHeap::new(),
            large: BinaryHeap::new(),
        }
    }

    fn add_num(&mut self, num: i32) {
        if self.small.is_empty() || num <= *self.small.peek().unwrap() {
            self.small.push(num);
        } else {
            self.large.push(Reverse(num));
        }

        if self.small.len() > self.large.len() + 1 {
            let val = self.small.pop().unwrap();
            self.large.push(Reverse(val));
        } else if self.large.len() > self.small.len() {
            let Reverse(val) = self.large.pop().unwrap();
            self.small.push(val);
        }
    }

    fn find_median(&self) -> f64 {
        if self.small.len() > self.large.len() {
            *self.small.peek().unwrap() as f64
        } else {
            (*self.small.peek().unwrap() as f64 + self.large.peek().unwrap().0 as f64) / 2.0
        }
    }
}

impl Solution {
    pub fn median_sliding_window(nums: Vec<i32>, k: i32) -> Vec<f64> {
        let k = k as usize;
        let mut result = Vec::new();
        let mut mf = MedianFinder::new();

        for i in 0..nums.len() {
            mf.add_num(nums[i]);
            if i >= k {
                let num_to_remove = nums[i - k];
                if num_to_remove <= *mf.small.peek().unwrap() {
                    let mut temp = Vec::new();
                    while let Some(num) = mf.small.pop() {
                        if num == num_to_remove {
                            break;
                        }
                        temp.push(num);
                    }
                    for num in temp.into_iter().rev() {
                        mf.small.push(num);
                    }
                } else {
                    let mut temp = Vec::new();
                    while let Some(Reverse(num)) = mf.large.pop() {
                        if num == num_to_remove {
                            break;
                        }
                        temp.push(Reverse(num));
                    }
                    for Reverse(num) in temp.into_iter().rev() {
                        mf.large.push(Reverse(num));
                    }
                }
                if mf.small.len() < mf.large.len() {
                    let Reverse(val) = mf.large.pop().unwrap();
                    mf.small.push(val);
                }
            }
            if i >= k - 1 {
                result.push(mf.find_median());
            }
        }
        result
    }
}