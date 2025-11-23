impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn minimum_xor_sum(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let mut heap = BinaryHeap::new();
        heap.push((0, 0, 0));

        let mut visited = vec![false; 1 << n];

        while let Some((cost, mask, i)) = heap.pop() {
            if i == n {
                return -cost;
            }
            if visited[mask] {
                continue;
            }
            visited[mask] = true;

            for j in 0..n {
                if mask & (1 << j) == 0 {
                    let new_mask = mask | (1 << j);
                    let new_cost = cost + ((nums1[i] ^ nums2[j]) as i32);
                    heap.push((new_cost, new_mask, i + 1));
                }
            }
        }

        -1
    }
}
}