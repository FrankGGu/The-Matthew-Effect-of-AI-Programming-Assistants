impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

struct Solution {}

impl Solution {
    pub fn kth_smallest_prime_fraction(mut arr: Vec<i32>, k: i32) -> Vec<i32> {
        let n = arr.len();
        let mut heap = BinaryHeap::new();

        for i in 0..n {
            heap.push((arr[i] as f64 / arr[n - 1] as f64, i, n - 1));
        }

        for _ in 0..k - 1 {
            if let Some((_, i, j)) = heap.pop() {
                if j - 1 > i {
                    heap.push((arr[i] as f64 / arr[j - 1] as f64, i, j - 1));
                }
            }
        }

        if let Some((_, i, j)) = heap.pop() {
            vec![arr[i], arr[j]]
        } else {
            vec![]
        }
    }
}
}