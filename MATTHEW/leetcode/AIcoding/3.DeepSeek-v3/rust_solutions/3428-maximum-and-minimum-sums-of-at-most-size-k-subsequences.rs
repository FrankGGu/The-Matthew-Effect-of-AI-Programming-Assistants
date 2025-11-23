use std::collections::BinaryHeap;

impl Solution {
    pub fn max_sum_subsequence(nums: Vec<i32>, k: i32) -> i64 {
        let k = k as usize;
        let mut max_heap = BinaryHeap::new();
        let mut max_sum = 0;
        for &num in &nums {
            max_heap.push(num);
        }
        for _ in 0..k {
            if let Some(num) = max_heap.pop() {
                if num > 0 {
                    max_sum += num as i64;
                }
            }
        }

        let mut min_heap = BinaryHeap::new();
        let mut min_sum = 0;
        for &num in &nums {
            min_heap.push(-num);
        }
        for _ in 0..k {
            if let Some(num) = min_heap.pop() {
                min_sum += -num as i64;
            }
        }

        vec![max_sum, min_sum]
    }
}