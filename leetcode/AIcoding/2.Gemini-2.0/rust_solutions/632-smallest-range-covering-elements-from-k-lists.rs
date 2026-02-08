use std::cmp::{max, min, Reverse};
use std::collections::BinaryHeap;

impl Solution {
    pub fn smallest_range(nums: Vec<Vec<i32>>) -> Vec<i32> {
        let k = nums.len();
        let mut pq = BinaryHeap::new();
        let mut max_val = i32::MIN;
        let mut indices = vec![0; k];

        for i in 0..k {
            pq.push(Reverse((nums[i][0], i)));
            max_val = max(max_val, nums[i][0]);
        }

        let mut range_start = 0;
        let mut range_end = i32::MAX;

        loop {
            let Reverse((min_val, list_index)) = pq.pop().unwrap();

            if max_val - min_val < range_end - range_start {
                range_start = min_val;
                range_end = max_val;
            }

            indices[list_index] += 1;
            if indices[list_index] == nums[list_index].len() {
                break;
            }

            let next_val = nums[list_index][indices[list_index]];
            pq.push(Reverse((next_val, list_index)));
            max_val = max(max_val, next_val);
        }

        vec![range_start, range_end]
    }
}