impl Solution {

use std::cmp;

impl Solution {
    pub fn minimum_limit(bags: Vec<i32>, max_operations: i32) -> i32 {
        let mut left = 1;
        let mut right = *bags.iter().max().unwrap();

        while left < right {
            let mid = left + (right - left) / 2;
            let mut operations = 0;

            for &bag in &bags {
                if bag > mid {
                    operations += (bag - 1) / mid;
                }
            }

            if operations <= max_operations {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }
}
}