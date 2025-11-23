use std::collections::BinaryHeap;

pub fn minimum_deviation(nums: Vec<i32>) -> i32 {
    let mut heap = BinaryHeap::new();
    let mut min_val = i32::MAX;

    for num in nums {
        let value = if num % 2 == 0 { num } else { num * 2 };
        heap.push(value);
        min_val = min_val.min(value);
    }

    let mut min_deviation = i32::MAX;

    while let Some(max_val) = heap.pop() {
        min_deviation = min_deviation.min(max_val - min_val);
        if max_val % 2 == 0 {
            let next_val = max_val / 2;
            heap.push(next_val);
            min_val = min_val.min(next_val);
        } else {
            break;
        }
    }

    min_deviation
}