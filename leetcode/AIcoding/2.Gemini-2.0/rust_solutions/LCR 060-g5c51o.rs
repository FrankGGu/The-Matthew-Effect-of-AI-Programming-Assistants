use std::collections::HashMap;
use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Eq, PartialEq)]
struct Pair {
    num: i32,
    count: i32,
}

impl Ord for Pair {
    fn cmp(&self, other: &Self) -> Ordering {
        other.count.cmp(&self.count)
    }
}

impl PartialOrd for Pair {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn top_k_frequent(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut heap: BinaryHeap<Pair> = BinaryHeap::new();
        for (&num, &count) in &counts {
            heap.push(Pair { num: num, count: count });
        }

        let mut result: Vec<i32> = Vec::new();
        for _ in 0..k {
            if let Some(pair) = heap.pop() {
                result.push(pair.num);
            }
        }

        result
    }
}