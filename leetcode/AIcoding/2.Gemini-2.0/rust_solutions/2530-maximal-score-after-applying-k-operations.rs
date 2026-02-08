use std::collections::BinaryHeap;

impl Solution {
    pub fn max_score(nums: Vec<i32>, k: i32) -> i64 {
        let mut heap = BinaryHeap::new();
        for &num in &nums {
            heap.push(num);
        }

        let mut score: i64 = 0;
        for _ in 0..k {
            let max_val = heap.pop().unwrap();
            score += max_val as i64;
            heap.push((max_val + 2 - 1) / 2);
        }

        score
    }
}