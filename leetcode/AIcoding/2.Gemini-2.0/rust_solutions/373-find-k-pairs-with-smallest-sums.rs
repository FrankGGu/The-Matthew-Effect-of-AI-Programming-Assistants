use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn k_smallest_pairs(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
        let mut heap: BinaryHeap<Reverse<(i32, usize, usize)>> = BinaryHeap::new();
        let mut result: Vec<Vec<i32>> = Vec::new();

        if nums1.is_empty() || nums2.is_empty() {
            return result;
        }

        for i in 0..std::cmp::min(nums1.len(), k as usize) {
            heap.push(Reverse((nums1[i] + nums2[0], i, 0)));
        }

        for _ in 0..std::cmp::min(k as usize, nums1.len() * nums2.len()) {
            if let Some(Reverse((sum, i, j))) = heap.pop() {
                result.push(vec![nums1[i], nums2[j]]);

                if j + 1 < nums2.len() {
                    heap.push(Reverse((nums1[i] + nums2[j + 1], i, j + 1)));
                }
            } else {
                break;
            }
        }

        result
    }
}