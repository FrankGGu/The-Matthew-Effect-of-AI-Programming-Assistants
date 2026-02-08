use std::collections::BinaryHeap;

impl Solution {
    pub fn minimum_deviation(nums: Vec<i32>) -> i32 {
        let mut max_heap = BinaryHeap::new();
        let mut min_val = i32::MAX;

        for &num in nums.iter() {
            let mut n = num;
            if n % 2 != 0 {
                n *= 2;
            }
            max_heap.push(n);
            min_val = min_val.min(n);
        }

        let mut min_deviation = i32::MAX;

        while let Some(max) = max_heap.pop() {
            min_deviation = min_deviation.min(max - min_val);

            if max % 2 != 0 {
                break;
            }

            let new_val = max / 2;
            max_heap.push(new_val);
            min_val = min_val.min(new_val);
        }

        min_deviation
    }
}