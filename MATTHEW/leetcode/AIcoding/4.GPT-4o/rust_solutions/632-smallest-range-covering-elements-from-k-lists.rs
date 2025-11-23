use std::cmp::{self, Ordering};
use std::collections::{BinaryHeap, HashMap};

pub fn smallest_range(nums: Vec<Vec<i32>>) -> Vec<i32> {
    let mut min_heap = BinaryHeap::new();
    let mut max_val = i32::MIN;
    let k = nums.len();

    for i in 0..k {
        if let Some(&num) = nums[i].first() {
            min_heap.push((cmp::Reverse(num), i, 0));
            max_val = cmp::max(max_val, num);
        }
    }

    let mut range = vec![];
    let mut min_range = i32::MAX;

    while let Some((cmp::Reverse(min_val), list_index, index)) = min_heap.pop() {
        if max_val - min_val < min_range {
            min_range = max_val - min_val;
            range = vec![min_val, max_val];
        }

        if index + 1 < nums[list_index].len() {
            let next_val = nums[list_index][index + 1];
            min_heap.push((cmp::Reverse(next_val), list_index, index + 1));
            max_val = cmp::max(max_val, next_val);
        } else {
            break;
        }
    }

    range
}