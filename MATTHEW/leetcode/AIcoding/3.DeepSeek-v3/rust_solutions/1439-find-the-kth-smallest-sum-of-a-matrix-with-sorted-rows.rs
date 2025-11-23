use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn kth_smallest(mat: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        let mut current_sums = vec![0];

        for row in mat {
            let mut next_sums = Vec::new();
            let mut temp_heap = BinaryHeap::new();

            for &sum in &current_sums {
                for &num in &row {
                    temp_heap.push(Reverse(sum + num));
                    if temp_heap.len() > k as usize {
                        temp_heap.pop();
                    }
                }
            }

            current_sums = temp_heap.into_iter().map(|Reverse(x)| x).collect();
        }

        current_sums[k as usize - 1]
    }
}