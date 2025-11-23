impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn advantage_shuffle(mut nums: Vec<i32>, mut target: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut nums_with_index = nums.into_iter().enumerate().collect::<Vec<_>>();
        let mut target_with_index = target.into_iter().enumerate().collect::<Vec<_>>();

        nums_with_index.sort_by(|a, b| a.1.cmp(&b.1));
        target_with_index.sort_by(|a, b| a.1.cmp(&b.1));

        let mut result = vec![0; n];
        let mut i = 0;
        let mut j = 0;
        let mut heap = BinaryHeap::new();

        while i < n {
            if nums_with_index[i].1 > target_with_index[j].1 {
                heap.push((nums_with_index[i].0, nums_with_index[i].1));
                i += 1;
            } else {
                let (index, value) = heap.pop().unwrap();
                result[index] = nums_with_index[i].1;
                i += 1;
                j += 1;
            }
        }

        while let Some((index, value)) = heap.pop() {
            result[index] = value;
        }

        result
    }
}
}