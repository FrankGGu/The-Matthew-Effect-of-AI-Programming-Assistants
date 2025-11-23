impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn mice_and_cheese(trap_rewards: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for reward in trap_rewards {
            heap.push(Reverse(reward));
        }
        let mut total = 0;
        let k = k as usize;
        for _ in 0..k {
            if let Some(Reverse(r)) = heap.pop() {
                total += r;
            }
        }
        total
    }
}
}