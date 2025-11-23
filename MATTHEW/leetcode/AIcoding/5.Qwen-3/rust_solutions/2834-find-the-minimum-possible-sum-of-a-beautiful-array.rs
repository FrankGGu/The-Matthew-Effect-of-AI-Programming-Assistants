impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn min_possible_sum(n: i32, target: i32) -> i64 {
        let n = n as usize;
        let mut heap = BinaryHeap::new();
        let mut sum = 0i64;

        for i in 1..=n {
            heap.push(Reverse(i));
        }

        let mut used = vec![false; n + 1];
        let mut res = 0i64;

        while let Some(Reverse(x)) = heap.pop() {
            if x == target {
                res += x as i64;
                break;
            }
            if x > target {
                continue;
            }
            res += x as i64;
            let complement = target - x;
            if complement <= n && !used[complement] {
                used[complement] = true;
                heap.push(Reverse(complement));
            }
        }

        res
    }
}

struct Solution {}
}