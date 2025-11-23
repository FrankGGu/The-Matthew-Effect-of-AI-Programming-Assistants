use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn maximum_product(nums: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for &num in &nums {
            heap.push(Reverse(num));
        }

        let mut k = k;
        while k > 0 {
            if let Some(Reverse(min_val)) = heap.pop() {
                heap.push(Reverse(min_val + 1));
                k -= 1;
            }
        }

        let mut product: i64 = 1;
        let modulo: i64 = 1_000_000_007;
        while let Some(Reverse(num)) = heap.pop() {
            product = (product * (num as i64)) % modulo;
        }

        product as i32
    }
}

struct Solution;