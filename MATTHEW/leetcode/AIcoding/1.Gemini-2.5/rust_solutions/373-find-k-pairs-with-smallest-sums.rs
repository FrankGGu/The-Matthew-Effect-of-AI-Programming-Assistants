use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn k_smallest_pairs(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        if k == 0 || nums1.is_empty() || nums2.is_empty() {
            return result;
        }

        let mut pq: BinaryHeap<Reverse<(i32, usize, usize)>> = BinaryHeap::new();
        let k_usize = k as usize;

        for i in 0..nums1.len() {
            if i < k_usize {
                pq.push(Reverse((nums1[i] + nums2[0], i, 0)));
            } else {
                break;
            }
        }

        while result.len() < k_usize && !pq.is_empty() {
            if let Some(Reverse((_sum, i, j))) = pq.pop() {
                result.push(vec![nums1[i], nums2[j]]);

                if j + 1 < nums2.len() {
                    pq.push(Reverse((nums1[i] + nums2[j+1], i, j + 1)));
                }
            }
        }

        result
    }
}