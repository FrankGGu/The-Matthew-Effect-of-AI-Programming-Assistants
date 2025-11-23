impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn min_operations(mut nums1: Vec<i32>, mut nums2: Vec<i32>) -> i32 {
        let sum1 = nums1.iter().sum::<i32>();
        let sum2 = nums2.iter().sum::<i32>();

        if sum1 == sum2 {
            return 0;
        }

        if sum1 > sum2 {
            std::mem::swap(&mut nums1, &mut nums2);
        }

        let mut heap = BinaryHeap::new();

        for num in nums1.iter().rev() {
            if *num < 6 {
                heap.push(Reverse(6 - *num));
            }
        }

        for num in nums2.iter().rev() {
            if *num > 1 {
                heap.push(Reverse(*num - 1));
            }
        }

        let mut operations = 0;
        let target = sum2 - sum1;

        while !heap.is_empty() && target > 0 {
            let Reverse(diff) = heap.pop().unwrap();
            target -= diff;
            operations += 1;
        }

        if target > 0 {
            -1
        } else {
            operations
        }
    }
}
}