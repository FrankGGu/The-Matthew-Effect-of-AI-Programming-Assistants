use std::collections::BinaryHeap;

pub fn min_operations(nums: Vec<i32>) -> i32 {
    let total_sum: f64 = nums.iter().map(|&x| x as f64).sum();
    let half_sum = total_sum / 2.0;
    let mut heap: BinaryHeap<f64> = nums.iter().map(|&x| x as f64).collect();
    let mut current_sum = total_sum;
    let mut operations = 0;

    while current_sum > half_sum {
        if let Some(max) = heap.pop() {
            current_sum -= max / 2.0;
            heap.push(max / 2.0);
            operations += 1;
        }
    }

    operations
}