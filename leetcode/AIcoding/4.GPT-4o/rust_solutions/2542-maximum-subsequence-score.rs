use std::cmp::Ordering;

pub fn max_score(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> i64 {
    let n = nums1.len();
    let mut pairs: Vec<(i32, i32)> = nums1.into_iter().zip(nums2).collect();
    pairs.sort_unstable_by(|a, b| b.1.cmp(&a.1));

    let mut min_heap = std::collections::BinaryHeap::new();
    let mut sum = 0;
    let mut result = 0;

    for i in 0..n {
        sum += pairs[i].0;
        min_heap.push(pairs[i].0);

        if min_heap.len() > k as usize {
            sum -= min_heap.pop().unwrap();
        }

        if min_heap.len() == k as usize {
            result = result.max(sum as i64 * pairs[i].1 as i64);
        }
    }

    result
}