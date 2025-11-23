use std::cmp::Ordering;
use std::collections::BinaryHeap;

pub fn k_smallest_pairs(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    let mut heap = BinaryHeap::new();
    let n1 = nums1.len();
    let n2 = nums2.len();

    if n1 == 0 || n2 == 0 {
        return result;
    }

    for i in 0..n1 {
        heap.push((-(nums1[i] + nums2[0]), i, 0));
    }

    while let Some((neg_sum, i, j)) = heap.pop() {
        result.push(vec![nums1[i], nums2[j]]);

        if j + 1 < n2 {
            heap.push((-(nums1[i] + nums2[j + 1]), i, j + 1));
        }

        if result.len() as i32 == k {
            break;
        }
    }

    result
}