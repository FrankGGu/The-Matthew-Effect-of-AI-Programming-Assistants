use std::collections::BinaryHeap;

impl Solution {
    pub fn k_sum(nums: Vec<i32>, k: i32) -> i64 {
        let sum: i64 = nums.iter().filter(|&&x| x > 0).map(|&x| x as i64).sum();
        let mut nums = nums;
        nums.sort_by_key(|&x| x.abs());
        let mut heap = BinaryHeap::new();
        heap.push((sum, 0));
        let mut result = sum;
        for _ in 1..k {
            let (current, idx) = heap.pop().unwrap();
            result = current;
            if idx < nums.len() {
                let num = nums[idx] as i64;
                heap.push((current - num, idx + 1));
                if idx > 0 {
                    heap.push((current - num + nums[idx - 1] as i64, idx + 1));
                }
            }
        }
        result
    }
}