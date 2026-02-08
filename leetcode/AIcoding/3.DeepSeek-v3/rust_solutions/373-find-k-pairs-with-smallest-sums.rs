use std::collections::BinaryHeap;

impl Solution {
    pub fn k_smallest_pairs(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
        let mut heap = BinaryHeap::new();
        let k = k as usize;

        for &num1 in nums1.iter().take(k) {
            for &num2 in nums2.iter().take(k) {
                let sum = num1 + num2;
                if heap.len() < k {
                    heap.push((sum, num1, num2));
                } else {
                    if sum < heap.peek().unwrap().0 {
                        heap.pop();
                        heap.push((sum, num1, num2));
                    }
                }
            }
        }

        let mut result: Vec<Vec<i32>> = heap.into_iter().map(|(_, a, b)| vec![a, b]).collect();
        result.reverse();
        result
    }
}