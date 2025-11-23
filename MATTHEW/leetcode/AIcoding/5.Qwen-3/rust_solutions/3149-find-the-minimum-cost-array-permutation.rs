impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn min_cost(mut nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut heap = BinaryHeap::new();
        for i in 0..n {
            heap.push(Reverse((nums[i], i)));
        }

        let mut result = 0;
        let mut used = vec![false; n];

        while let Some(Reverse((val, idx))) = heap.pop() {
            if used[idx] {
                continue;
            }
            result += val;
            used[idx] = true;
            let next_idx = (idx + 1) % n;
            if !used[next_idx] {
                used[next_idx] = true;
                result += nums[next_idx];
            }
        }

        result
    }
}
}