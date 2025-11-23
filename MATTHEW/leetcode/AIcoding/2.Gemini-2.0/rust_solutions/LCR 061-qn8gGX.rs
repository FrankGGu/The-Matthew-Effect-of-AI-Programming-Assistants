use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn k_smallest_pairs(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
        let mut heap: BinaryHeap<Reverse<(i32, i32, i32)>> = BinaryHeap::new();
        let mut result: Vec<Vec<i32>> = Vec::new();

        for i in 0..std::cmp::min(nums1.len(), k as usize) {
            heap.push(Reverse((nums1[i] + nums2[0], i as i32, 0)));
        }

        for _ in 0..std::cmp::min(k as usize, nums1.len() * nums2.len()) {
            if let Some(Reverse((_, i, j))) = heap.pop() {
                result.push(vec![nums1[i as usize], nums2[j as usize]]);

                if (j as usize) + 1 < nums2.len() {
                    heap.push(Reverse((nums1[i as usize] + nums2[j as usize + 1], i, j + 1)));
                }
            }
        }

        result
    }
}