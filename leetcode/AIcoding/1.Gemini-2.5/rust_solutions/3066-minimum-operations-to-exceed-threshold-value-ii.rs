use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn min_operations(nums: Vec<i64>, k: i64) -> i32 {
        let mut heap = BinaryHeap::new();
        for num in nums {
            heap.push(Reverse(num));
        }

        let mut operations = 0;
        while let Some(Reverse(x)) = heap.pop() {
            if x >= k {
                heap.push(Reverse(x)); // Put it back, as it might be needed if we pop another element later
                break;
            }

            if let Some(Reverse(y)) = heap.pop() {
                let new_val = x * 2 + y;
                heap.push(Reverse(new_val));
                operations += 1;
            } else {
                // Should not happen based on problem constraints if a solution exists
                // If it happens, it means we couldn't find a second element to combine with x
                // and x itself is less than k.
                // This implies it's impossible to reach k, but the problem usually guarantees a solution.
                break; 
            }
        }

        operations
    }
}