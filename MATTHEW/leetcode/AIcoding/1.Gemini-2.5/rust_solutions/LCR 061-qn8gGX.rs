use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn k_smallest_pairs(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        if nums1.is_empty() || nums2.is_empty() || k == 0 {
            return result;
        }

        let mut heap: BinaryHeap<Reverse<(i32, usize, usize)>> = BinaryHeap::new();

        for i in 0..nums1.len().min(k as usize) {
            heap.push(Reverse((nums1[i] + nums2[0], i, 0)));
        }

        let mut count = 0;
        while count < k && !heap.is_empty() {
            if let Some(Reverse((_sum, i, j))) = heap.pop() {
                result.push(vec![nums1[i], nums2[j]]);
                count += 1;

                if j + 1 < nums2.len() {
                    heap.push(Reverse((nums1[i] + nums2[j + 1], i, j + 1)));
                }
            }
        }

        result
    }
}