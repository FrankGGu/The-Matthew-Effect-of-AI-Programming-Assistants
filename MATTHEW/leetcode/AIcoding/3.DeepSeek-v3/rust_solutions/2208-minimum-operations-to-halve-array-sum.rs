use std::collections::BinaryHeap;

impl Solution {
    pub fn halve_array(nums: Vec<i32>) -> i32 {
        let mut sum = 0.0;
        let mut heap = BinaryHeap::new();
        for &num in nums.iter() {
            let num = num as f64;
            sum += num;
            heap.push(num);
        }
        let target = sum / 2.0;
        let mut operations = 0;
        let mut reduced = 0.0;
        while reduced < target {
            if let Some(max) = heap.pop() {
                let half = max / 2.0;
                reduced += half;
                heap.push(half);
                operations += 1;
            }
        }
        operations
    }
}