use std::collections::HashMap;
use std::collections::BinaryHeap;

pub fn top_k_frequent(nums: Vec<i32>, k: i32) -> Vec<i32> {
    let mut count = HashMap::new();
    for num in nums {
        *count.entry(num).or_insert(0) += 1;
    }

    let mut heap = BinaryHeap::new();
    for (num, freq) in count {
        heap.push((freq, num));
        if heap.len() > k as usize {
            heap.pop();
        }
    }

    heap.into_iter().map(|(_, num)| num).collect()
}