impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn minimize_sum(mut nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        if n <= 2 {
            return 0;
        }

        let k = k as usize;

        let mut max_heap = BinaryHeap::new();
        for &num in &nums {
            max_heap.push(num);
        }

        for _ in 0..k {
            if let Some(max) = max_heap.pop() {
                max_heap.push(max - 1);
            }
        }

        let mut min_heap = BinaryHeap::new();
        for &num in &nums {
            min_heap.push(std::cmp::Reverse(num));
        }

        for _ in 0..k {
            if let Some(std::cmp::Reverse(min)) = min_heap.pop() {
                min_heap.push(std::cmp::Reverse(min + 1));
            }
        }

        let max = max_heap.into_iter().max().unwrap();
        let min = min_heap.into_iter().map(|x| x.0).min().unwrap();

        max - min
    }
}
}