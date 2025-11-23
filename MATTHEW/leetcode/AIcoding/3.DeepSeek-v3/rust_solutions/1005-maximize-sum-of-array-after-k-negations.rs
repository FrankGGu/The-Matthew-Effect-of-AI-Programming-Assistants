use std::collections::BinaryHeap;

impl Solution {
    pub fn largest_sum_after_k_negations(nums: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for num in nums {
            heap.push(-num);
        }
        let mut k = k;
        while k > 0 {
            if let Some(num) = heap.pop() {
                heap.push(-num);
            }
            k -= 1;
        }
        heap.into_iter().map(|x| -x).sum()
    }
}