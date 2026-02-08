use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn get_strongest(arr: Vec<i32>, k: i32) -> Vec<i32> {
        let mut arr = arr;
        arr.sort();
        let n = arr.len();
        let median = arr[(n - 1) / 2];
        let mut heap = BinaryHeap::new();

        for &value in &arr {
            let strength = (value - median).abs();
            heap.push((strength, value));
            if heap.len() > k as usize {
                heap.pop();
            }
        }

        let mut result: Vec<i32> = heap.into_iter().map(|(_, v)| v).collect();
        result.sort_unstable();
        result
    }
}