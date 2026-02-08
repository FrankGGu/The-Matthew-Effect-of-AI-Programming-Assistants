use std::collections::BinaryHeap;

impl Solution {
    pub fn max_kelements(nums: Vec<i32>, k: i32) -> i64 {
        let mut heap = BinaryHeap::new();
        for num in nums {
            heap.push(num);
        }
        let mut res = 0i64;
        for _ in 0..k {
            if let Some(max) = heap.pop() {
                res += max as i64;
                let new_num = (max as f64 / 3.0).ceil() as i32;
                heap.push(new_num);
            }
        }
        res
    }
}