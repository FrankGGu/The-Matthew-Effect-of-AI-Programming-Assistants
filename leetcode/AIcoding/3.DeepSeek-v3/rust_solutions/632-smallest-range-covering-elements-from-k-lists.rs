use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn smallest_range(nums: Vec<Vec<i32>>) -> Vec<i32> {
        let mut min_heap = BinaryHeap::new();
        let mut current_max = i32::MIN;
        let mut range_start = 0;
        let mut range_end = i32::MAX;

        for i in 0..nums.len() {
            let val = nums[i][0];
            min_heap.push(Reverse((val, i, 0)));
            current_max = current_max.max(val);
        }

        loop {
            let Reverse((min_val, list_idx, elem_idx)) = min_heap.pop().unwrap();

            if current_max - min_val < range_end - range_start {
                range_start = min_val;
                range_end = current_max;
            }

            if elem_idx + 1 == nums[list_idx].len() {
                break;
            }

            let next_val = nums[list_idx][elem_idx + 1];
            min_heap.push(Reverse((next_val, list_idx, elem_idx + 1)));
            current_max = current_max.max(next_val);
        }

        vec![range_start, range_end]
    }
}