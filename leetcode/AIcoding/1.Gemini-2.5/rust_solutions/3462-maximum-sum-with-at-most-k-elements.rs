use std::collections::BinaryHeap;

impl Solution {
    pub fn max_score(nums: Vec<i32>, k: i32) -> i64 {
        let mut heap = BinaryHeap::new();
        for num in nums {
            heap.push(num);
        }

        let mut total_score: i64 = 0;
        for _ in 0..k {
            if let Some(m) = heap.pop() {
                total_score += m as i64;
                let new_m = (m + 2) / 3;
                heap.push(new_m);
            } else {
                break; 
            }
        }

        total_score
    }
}