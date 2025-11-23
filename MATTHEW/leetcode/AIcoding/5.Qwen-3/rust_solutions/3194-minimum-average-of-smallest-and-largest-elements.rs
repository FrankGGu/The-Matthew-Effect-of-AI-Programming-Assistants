impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn minimum_average(mut nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;

        let mut max_heap = BinaryHeap::new();
        let mut min_heap = BinaryHeap::new();

        for &num in &nums {
            max_heap.push(num);
            min_heap.push(std::cmp::Reverse(num));
        }

        for _ in 0..k {
            let max_val = max_heap.pop().unwrap();
            let min_val = min_heap.pop().unwrap().0;
            let avg = (max_val + min_val) / 2;
            return avg;
        }

        0
    }
}
}