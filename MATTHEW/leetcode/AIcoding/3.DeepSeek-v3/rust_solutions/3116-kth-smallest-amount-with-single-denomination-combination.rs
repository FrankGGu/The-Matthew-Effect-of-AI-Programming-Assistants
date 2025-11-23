use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn kth_smallest_amount(coins: Vec<i32>, k: i32) -> i64 {
        let mut heap = BinaryHeap::new();
        heap.push(Reverse(0i64));
        let mut seen = std::collections::HashSet::new();
        seen.insert(0i64);
        let mut count = 0;
        let k = k as usize;

        while let Some(Reverse(current)) = heap.pop() {
            count += 1;
            if count == k {
                return current;
            }
            for &coin in coins.iter() {
                let next = current + coin as i64;
                if !seen.contains(&next) {
                    seen.insert(next);
                    heap.push(Reverse(next));
                }
            }
        }
        -1
    }
}