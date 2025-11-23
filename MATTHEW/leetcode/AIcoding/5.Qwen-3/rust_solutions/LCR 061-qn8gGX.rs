impl Solution {

use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn k_smallest_pairs(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
        let mut heap = BinaryHeap::new();
        let mut result = Vec::new();
        let k = k as usize;

        for i in 0..nums1.len() {
            heap.push((-(nums1[i] + nums2[0]), 0, i));
        }

        while !heap.is_empty() && result.len() < k {
            let (sum, j, i) = heap.pop().unwrap();
            result.push(vec![nums1[i], nums2[j]]);

            if j + 1 < nums2.len() {
                heap.push((-(nums1[i] + nums2[j + 1]), j + 1, i));
            }
        }

        result
    }
}
}