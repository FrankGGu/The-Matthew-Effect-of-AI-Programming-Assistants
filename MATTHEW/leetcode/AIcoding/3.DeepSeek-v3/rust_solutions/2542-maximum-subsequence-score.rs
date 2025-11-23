use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn max_score(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> i64 {
        let k = k as usize;
        let mut pairs: Vec<_> = nums1.into_iter().zip(nums2.into_iter()).collect();
        pairs.sort_by(|a, b| b.1.cmp(&a.1));

        let mut heap = BinaryHeap::new();
        let mut sum = 0i64;
        let mut res = 0i64;

        for (i, (num1, num2)) in pairs.iter().enumerate() {
            sum += *num1 as i64;
            heap.push(Reverse(*num1 as i64));

            if heap.len() > k {
                if let Some(Reverse(min)) = heap.pop() {
                    sum -= min;
                }
            }

            if heap.len() == k {
                res = res.max(sum * (*num2 as i64));
            }
        }

        res
    }
}