impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut heap = BinaryHeap::new();

        for num in nums {
            heap.push(num);
        }

        let mid = n / 2;
        let mut count = 0;

        for _ in 0..mid {
            let val = heap.pop().unwrap();
            if val < k {
                count += k - val;
            }
        }

        count
    }
}
}