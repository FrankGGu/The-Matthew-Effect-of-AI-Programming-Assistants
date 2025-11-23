use std::cmp::{max, min};
use std::collections::BinaryHeap;

pub fn max_sum(nums: Vec<i32>, k: i32) -> i32 {
    let mut heap = BinaryHeap::new();
    let mut sum = 0;

    for &num in &nums {
        heap.push(num);
    }

    for _ in 0..k {
        if let Some(max_num) = heap.pop() {
            sum += max_num;
        }
    }

    sum
}

pub fn min_sum(nums: Vec<i32>, k: i32) -> i32 {
    let mut heap = BinaryHeap::new();
    let mut sum = 0;

    for &num in &nums {
        heap.push(-num);
    }

    for _ in 0..k {
        if let Some(min_num) = heap.pop() {
            sum += -min_num;
        }
    }

    sum
}

pub fn max_and_min_sums(nums: Vec<i32>, k: i32) -> (i32, i32) {
    (max_sum(nums.clone(), k), min_sum(nums, k))
}