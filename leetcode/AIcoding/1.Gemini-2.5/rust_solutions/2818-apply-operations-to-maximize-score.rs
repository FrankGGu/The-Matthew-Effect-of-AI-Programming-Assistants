use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn max_score(nums: Vec<i32>, k: i32) -> i64 {
        let mut heap = BinaryHeap::new();

        for num in nums {
            heap.push(Reverse(num)); // Use Reverse to make BinaryHeap act as a max-heap
        }

        let mut total_score: i64 = 0;

        for _ in 0..k {
            // Extract the largest element from the heap
            if let Some(Reverse(val)) = heap.pop() {
                total_score += val as i64; // Add its value to the total score

                // Calculate the new value (floor(val / 3)) and push it back into the heap
                let new_val = val / 3;
                heap.push(Reverse(new_val));
            }
        }

        total_score
    }
}