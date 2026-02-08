use std::cmp::Ordering;
use std::collections::BinaryHeap;

pub fn k_smallest_pairs(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    let mut heap = BinaryHeap::new();

    for i in 0..nums1.len() {
        for j in 0..nums2.len() {
            if heap.len() < k as usize {
                heap.push((-(nums1[i] + nums2[j]), i, j));
            } else if let Some(&top) = heap.peek() {
                if -(nums1[i] + nums2[j]) > top.0 {
                    break;
                }
                heap.pop();
                heap.push((-(nums1[i] + nums2[j]), i, j));
            }
        }
    }

    while let Some((_, i, j)) = heap.pop() {
        result.push(vec![nums1[i], nums2[j]]);
    }

    result.reverse();
    result
}