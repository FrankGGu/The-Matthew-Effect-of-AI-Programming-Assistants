use std::collections::BinaryHeap;

impl Solution {
    pub fn max_subsequence(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let mut heap = BinaryHeap::new();
        for (i, &num) in nums.iter().enumerate() {
            heap.push((num, i));
        }

        let mut indices = Vec::with_capacity(k);
        for _ in 0..k {
            if let Some((_, i)) = heap.pop() {
                indices.push(i);
            }
        }

        indices.sort_unstable();
        indices.into_iter().map(|i| nums[i]).collect()
    }
}