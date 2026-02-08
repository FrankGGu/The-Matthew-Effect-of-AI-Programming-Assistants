use std::collections::BinaryHeap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for &num in nums.iter() {
            heap.push(-num);
        }
        let mut operations = 0;
        while heap.len() >= 2 {
            let first = -heap.pop().unwrap();
            if first >= k {
                return operations;
            }
            let second = -heap.pop().unwrap();
            let new_num = first * 2 + second;
            heap.push(-new_num);
            operations += 1;
        }
        operations
    }
}