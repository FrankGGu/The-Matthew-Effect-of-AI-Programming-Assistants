use std::collections::BinaryHeap;

pub fn max_sum(k: i32, nums: Vec<i32>) -> i32 {
    let mut heap = BinaryHeap::new();
    for &num in &nums {
        heap.push(num);
    }

    let mut sum = 0;
    for _ in 0..k {
        if let Some(max) = heap.pop() {
            sum += max;
        }
    }
    sum
}