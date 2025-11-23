impl Solution {

use rand::distributions::{Distribution, Uniform};
use rand::Rng;
use std::cmp::Ordering;
use std::collections::BinaryHeap;

struct Solution {
    prefix_sums: Vec<i32>,
}

impl Solution {
    fn new(w: Vec<i32>) -> Self {
        let mut prefix_sums = Vec::new();
        let mut sum = 0;
        for weight in w {
            sum += weight;
            prefix_sums.push(sum);
        }
        Solution { prefix_sums }
    }

    fn pick_index(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let dist = Uniform::new(0, self.prefix_sums.last().unwrap() + 1);
        let mut idx = dist.sample(&mut rng);
        idx -= 1;
        let mut left = 0;
        let mut right = self.prefix_sums.len() - 1;
        while left < right {
            let mid = (left + right) / 2;
            if self.prefix_sums[mid] > idx {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        left as i32
    }
}
}