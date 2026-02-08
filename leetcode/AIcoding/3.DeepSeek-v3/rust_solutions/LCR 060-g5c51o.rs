use std::collections::HashMap;
use std::cmp::Reverse;

impl Solution {
    pub fn top_k_frequent(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut frequency = HashMap::new();
        for num in nums {
            *frequency.entry(num).or_insert(0) += 1;
        }

        let mut heap = std::collections::BinaryHeap::new();
        for (num, count) in frequency {
            heap.push((Reverse(count), num));
            if heap.len() > k as usize {
                heap.pop();
            }
        }

        heap.into_iter().map(|(_, num)| num).collect()
    }
}