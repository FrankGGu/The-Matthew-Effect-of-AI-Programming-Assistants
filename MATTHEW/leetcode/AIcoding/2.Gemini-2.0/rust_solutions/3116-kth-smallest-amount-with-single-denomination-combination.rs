use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn kth_smallest(denominations: Vec<i32>, k: i32) -> i64 {
        let mut heap = BinaryHeap::new();
        heap.push(Reverse(0));
        let mut seen = std::collections::HashSet::new();
        seen.insert(0);

        for _ in 0..k {
            let Reverse(curr) = heap.pop().unwrap();

            for &denomination in &denominations {
                let next = curr + denomination as i64;
                if !seen.contains(&next) {
                    heap.push(Reverse(next));
                    seen.insert(next);
                }
            }
        }

        let Reverse(result) = heap.pop().unwrap();
        result
    }
}

struct Solution;