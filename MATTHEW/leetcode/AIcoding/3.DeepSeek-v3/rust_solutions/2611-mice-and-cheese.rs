use std::collections::BinaryHeap;

impl Solution {
    pub fn mice_and_cheese(reward1: Vec<i32>, reward2: Vec<i32>, k: i32) -> i32 {
        let n = reward1.len();
        let k = k as usize;
        let mut heap = BinaryHeap::new();
        let mut total = 0;

        for i in 0..n {
            heap.push(reward1[i] - reward2[i]);
            total += reward2[i];
        }

        for _ in 0..k {
            if let Some(diff) = heap.pop() {
                total += diff;
            }
        }

        total
    }
}